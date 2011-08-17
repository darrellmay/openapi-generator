package com.wordnik.swagger.common
{
	import com.wordnik.swagger.common.ApiUserCredentials;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.utils.UIDUtil;
	
	public class SwaggerApi extends EventDispatcher
	{
			
		protected var _apiUsageCredentials:ApiUserCredentials;
		protected var _apiEventNotifier:EventDispatcher;
		protected var _apiInvoker: ApiInvoker;
		
		protected var apiProxyServerUrl:String = "http://apihost.wordnik.com/";
		protected var _baseUrl: String = "http://beta.wordnik.com/api/";
		protected var _useProxyServer: Boolean = true;
		protected var proxyHostName:String = "api.wordnik.com";
		
		protected static const DELETE_DATA_DUMMY:String = "dummyDataRequiredForDeleteOverride";
		protected static const X_HTTP_OVERRIDE_KEY:String = "X-HTTP-Method-Override";
		protected static const CONTENT_TYPE_HEADER_KEY:String = "Content-Type";
		
		
		/**
		 * Constructor for the api client
		 * @param apiCredentials Wrapper object for tokens and hostName required towards authentication
		 * @param eventDispatcher Optional event dispatcher that when provided is used by the SDK to dispatch any Response
		 */
		public function SwaggerApi(apiCredentials: ApiUserCredentials, eventDispatcher: EventDispatcher = null) {
			super();
			_apiUsageCredentials = apiCredentials;
			_apiEventNotifier = eventDispatcher;
		}
		
		public function useProxyServer(value:Boolean, proxyServerUrl: String = null):void {
			_useProxyServer = value;
		}
		
		protected function getApiInvoker():ApiInvoker {
			if(_apiInvoker == null){
				if(_apiEventNotifier == null){
					_apiEventNotifier = this;
				}
				_apiInvoker = new ApiInvoker(_apiUsageCredentials, _apiEventNotifier, _useProxyServer);
			}
			return _apiInvoker;
		}
		
		protected function getUniqueId():String {
			return UIDUtil.createUID();
		}
		
		/**
		 * Method for returning the path value
		 * For a string value an empty value is returned if the value is null
		 * @param value
		 * @return
		 */
		protected static function toPathValue(value: Object): String {
			if(value is Array){
				return arrayToPathValue(value as Array);
			}
			return  value == null ? "" : value.toString();
		}
		
		/**
		 * Method for returning a path value
		 * For a list of objects a comma separated string is returned
		 * @param objects
		 * @return
		 */
		protected static function arrayToPathValue(objects: Array): String {
			var out: String = "";
			
			return objects.join(",");
		}
		
	}
}