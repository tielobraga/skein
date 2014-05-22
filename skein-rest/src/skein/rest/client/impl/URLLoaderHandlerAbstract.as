/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/6/14
 * Time: 10:35 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.client.impl
{
import skein.core.skein_internal;
import skein.rest.core.Config;

use namespace skein_internal;
public class URLLoaderHandlerAbstract
{
    public function URLLoaderHandlerAbstract(client:DefaultRestClient)
    {
        super();

        this.client = client;
    }

    protected var client:DefaultRestClient;

    protected var responseCode:int;

    protected var attempts:uint;

    protected function status(status:int):void
    {
        responseCode = status;

        if (client.statusCallback != null)
            client.statusCallback(status);
    }

    protected function progress(loaded:Number, total:Number):void
    {
        if (client.progressCallback != null)
            client.progressCallback(loaded, total);
    }

    protected function result(data:Object):void
    {
        if (client.resultCallback != null)
        {
            client.decodeResult(data,
                function(data:Object):void
                {
                    if (client.resultCallback.length == 2)
                        client.resultCallback(data, responseCode);
                    else
                        client.resultCallback(data);

                    client.free();
                }
            );
        }
        else
        {
            client.free();
        }
    }

    protected function error(data:Object):void
    {
        if (client.errorInterceptor != null)
        {
            client.decodeError(data,
                function(info:Object):void
                {
                    interceptError(info);
                }
            );
        }
        else if (client.errorCallback != null)
        {
            client.decodeError(data,
                function(info:Object):void
                {
                    proceedError(info);
                }
            );
        }
        else
        {
            client.free();
        }
    }

    private function interceptError(info:Object):void
    {
        var proceedErrorCallback:Function = function():void
        {
            proceedError(info);
        }

        var retryRequestCallback:Function = function():void
        {
            retryRequest();
        }

        if (client.errorInterceptor.length == 2)
            client.errorInterceptor(info, responseCode)(attempts, proceedErrorCallback, retryRequestCallback);
        else
            client.errorInterceptor(info)(attempts, proceedErrorCallback, retryRequestCallback);
    }

    private function retryRequest():void
    {
        attempts++;

        client.retry();
    }

    private function proceedError(info:Object):void
    {
        if (client.errorCallback.length == 2)
            client.errorCallback(info, responseCode);
        else
           client.errorCallback(info);

        client.free();
    }
}
}