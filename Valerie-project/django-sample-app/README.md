# Django sample project

This repo contains a sample Django project used with our DevOps interviewing exercise.

This app exposes a single API endpoint that returns a count of objects from the database.

Database DSN is expected to be provided via `DATABASE_URL` environment variable.

### API Endpoint

`/api/articles/count`

#### Response

The API response should always return in the shape of:

```
{ "count": <int> }
```

and with a response code of `200` when requested with the appropriate `Content-type: application/json` header. 

A browser request should respond with the default Django REST Framework UI.
