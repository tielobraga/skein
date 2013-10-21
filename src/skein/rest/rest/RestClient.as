/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/17/13
 * Time: 6:27 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.rest
{
public interface RestClient
{
    function addHeader(value:Object):RestClient;
    function headers(value:Array):RestClient;

    function addParam(key:String, value:String):RestClient;
    function params(value:Object):RestClient;

    function accessToken(value:String, key:String = "access_token"):RestClient;

    function contentType(value:String):RestClient;

    function encoder(value:Function):RestClient;
    function decoder(value:Function):RestClient;

    function result(handler:Function):RestClient;
    function status(handler:Function):RestClient;
    function error(handler:Function):RestClient;

    function get():void;
    function post(data:Object = null):void;
    function put(data:Object = null):void;
    function del():void;
}
}