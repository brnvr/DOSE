// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function events_in_realm(events, realm) {
	return array_filter(events, method({realm: realm}, function(event) {
		return event[0] == all || event[0] == realm	
	}))
}