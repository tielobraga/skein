/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/18/13
 * Time: 10:16 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.validators
{
import flash.events.IEventDispatcher;

import skein.validators.events.ValidationEvent;

public interface Validator extends IEventDispatcher
{
    function get source():Object;
    function set source(value:Object):void;

    function get property():String;
    function set property(value:String):void;

    function get triggerEvent():String;
    function set triggerEvent(value:String):void;

    function get silent():Boolean;
    function set silent(value:Boolean):void;

    function validate(value:Object = null, silentValidation:Boolean = false):ValidationEvent;
}
}
