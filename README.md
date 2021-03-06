I wrote this small app as part of an interview task.

## Set-up

1 - Check out status-app from GitHub

```
$ git clone git@github.com:speric/status-app.git
$ cd status-app
```

2 - Create `config/database.yml` (blank one [here](https://gist.github.com/4063763)) with the proper credentials for your local db

3 - Run setup script (install gems via Bundler, creates local dbs, seeds db with initial data)
```
$ ./app-setup.sh
```

4 - Start local server
```
$ rails server
```

5 - Navigate to [http://localhost:3000](http://localhost:3000)

## Usage

The app starts with an `UP` status.  App status can be updated via `curl`.  Responses are in JSON format.  Valid `status` values are `UP` or `DOWN`.  You can also send a `status_message`. Either a `status` or `status_message` must be present in the request.  If `status` is empty, the current status of the application will remain unchanged. Valid requests will return an `HTTP 200`, requests with errors will return an `HTTP 422`.

**Update status with message**
```
$ curl -i -d "app_status[status]=UP" -d "app_status[status_message]=24 hrs no downtime" http://localhost:3000/status

HTTP/1.1 200 OK 
Content-Length: 127
...
{
  "app_status":{
    "id":19,
    "status":"UP",
    "status_message":"24 hrs no downtime",
    "created_at":"2012-11-12T20:44:55-05:00",
    "updated_at":"2012-11-12T20:44:55-05:00"
  }
}
```

**Update status, no message**
```
$ curl -i -d "app_status[status]=UP" http://localhost:3000/status

HTTP/1.1 200 OK 
Content-Length: 127
...
{
  "app_status":{
    "id":20,
    "status":"UP",
    "status_message":null,
    "created_at":"2012-11-12T20:44:55-05:00",
    "updated_at":"2012-11-12T20:44:55-05:00"
  }
}
```

**Update status_message, no status (current state of app is UP)**
```
$ curl -i -d "app_status[status_message]=24 hours with no downtime" http://localhost:3000/status

HTTP/1.1 200 OK 
Content-Length: 150
...
{
  "app_status":{
    "id":21,
    "status":"UP",
    "status_message":"24 hours with no downtime",
    "created_at":"2012-11-12T20:50:03-05:00",
    "updated_at":"2012-11-12T20:50:03-05:00"
  }
}
```
**Update status, invalid status**

```
$ curl -i -d "app_status[status]=CHAOS" http://localhost:3000/status

HTTP/1.1 422  
Content-Length: 53
..
{
  "errors":{"status":["CHAOS is not a valid status"]}
}
```

**Tests**
```
$ rake db:test:load
$ rake test
```
