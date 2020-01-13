# README

Backend system which integrates with air conditioning units and provides an admin panel to manage them.

## Setup
1. `bundle install`
1. `rake db:create`
1. `rake db:migrate`
1. `rails s`


## Further work needed
* Testing
* Login page styling
* Real token auth for devices
* Device Uniqueness by serial number
* Send notifications via email
* Browser Notifcations
* Pagination for listing pages

## API Documentation

The API is on the same url as the admin, production can be found here: https://theorem-ac.herokuapp.com/

### Register a device
A device must be registered to appear in the system, and to get credentials for sending statuses
* Path: `/devices.json`
* Request type: `POST`
* Header: `Content-Type: application/json`
* Body Example: `{"device":{"serial_number":"SERIAL_NUMBER","firmware_version":"FIRMWARE_VERSION"}}`

When registering, the API will return a copy of your new device object, store the `id` and `token` for future calls

### Send a status
A device can send a status which represents a set of sensor readings and a health status. You must include the token received from the registration step as an authorization header to create statuses, and it must match the one assigned to the device id passed in the body. A status can be any combination of sensor readings, and health status, but the collected date/time must be supplied. 
* Path: `/statuses.json`
* Request type: `POST`
* Headers:
    * `Content-Type: application/json`
    * `Authorization: Bearer TOKEN` - replace token with your id
* Body Example: 
```
{
    "status":
    {
        "device_id": "ID",
        "air_humidity": "40",
        "temperature": "60",
        "carbon_monoxide":"8",
        "health_status": "needs_new_filter",
        "collected_at": "2020-01-09 17:10:31 UTC"
    }
 }
```
         
* Status attributes:
    * `temperature `: Temperature in Celsius.
    * `air_humidity`: Air humidity percentage.
    * `carbon_monoxide`: Carbon Monoxide level in the air (PPM).
    * `health_status`: Device health status. It can be any text, less than 150 characters
    * `collected_at`: (REQUIRED) Time of data collection YYYY-MM-DD hh:mm:ss UTC

### Bulk Send Statuses
When a device has been unable to reach the server for a time, it may be necessary to send multiple statuses at once to catch up which can be done using bulk create. As before the token must be included in an authorization header. For bulk creation though, the device_id must be at the root of the body json. Statuses may only be provided for one device per request.
* Path: `/statuses/bulk_create.json`
* Request type: `POST`
* Headers:
    * `Content-Type: application/json`
    * `Authorization: Bearer TOKEN` - replace token with your id
* Body Example: 
```
           {
           	"device_id": "ID",
           	"statuses":
           	[
           	{
           		
           		"air_humidity": "44",
           		"temperature": "75",
           		"carbon_monoxide":"5",
           		"health_status": "needs_service",
           		"collected_at": "2020-01-09 22:11:31 UTC"
           	},
           	{
           		
           		"air_humidity": "44",
           		"temperature": "74",
           		"carbon_monoxide":"5",
           		"health_status": "fine",
           		"collected_at": "2020-01-09 22:12:31 UTC"
           	}
           	]
           	}
```


