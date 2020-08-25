! function(root, factory) {
	if (typeof exports == 'object' && typeof module != 'undefined') {
		module.exports = factory()
	} else if (typeof define == 'function' && define.amd) {
		define(factory)
	} else {
		document.addEventListener('plusready', function(){
		var moduleName = 'sharetraceplugin';
		root.plus[moduleName] = factory()
		},false);
	}
}(this, function() {
	var _BARCODE = 'sharetraceplugin';
	var plugin = {
		getInstallTrace : function (successCallback) {
			var success = typeof successCallback !== 'function' ? null : function(args) {
				successCallback(args);
			},
			callbackID = plus.bridge.callbackId(success, null);
			return plus.bridge.exec(_BARCODE, "getInstallTrace", [callbackID]);
		}
	};
	return plugin;
});
