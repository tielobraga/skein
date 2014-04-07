/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/18/13
 * Time: 1:42 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.validators.validators
{
import skein.validators.data.ValidationResult;

public class EmailValidator extends BasicValidator
{
    //--------------------------------------------------------------------------
    //
    //  Class constants                                                            [_A-Za-z0-9-\\+]
    //
    //--------------------------------------------------------------------------

    private static const EMAIL_REGEXP:RegExp = /^[a-z][\w.-\\+]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function EmailValidator()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    private var _incorrectEmailError:String = "Wrong email address.";

    public function get incorrectEmailError():String
    {
        return _incorrectEmailError;
    }

    public function set incorrectEmailError(value:String):void
    {
        _incorrectEmailError = value;
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override protected function doValidation(value:Object):Array
    {
        var results:Array = super.doValidation(value);

        if (results.length > 0)
            return results;
        else
            return validateEmail(value);
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    private function validateEmail(value:Object):Array
    {
        var results:Array = [];

        if (required)
        {
            if (!EMAIL_REGEXP.test(String(value)))
            {
                results.push(new ValidationResult(true, incorrectEmailError))
            }
        }

        return results;
    }
}
}
