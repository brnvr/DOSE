function seed_group_remove(realm, group, value) {
	static realm_list = [realms.thisside, realms.otherside]
	
	static remove = function(realm, group, value) {
		var arr = global.seed_groups[realm][group]
	
		var index = array_find(arr, value)
	
		array_delete(arr, index, 1)	
	}
	
	if (realm == all) {	
		array_foreach(realm_list, method({ remove, group, value }, function(realm) {
			remove(realm, group, value)	
		}))
	} else {
		remove(realm, group, value)
	}
}