

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import mx.controls.Label;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property label1 (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'label1' moved to '_1110417475label1'
	 */

    [Bindable(event="propertyChange")]
    public function get label1():mx.controls.Label
    {
        return this._1110417475label1;
    }

    public function set label1(value:mx.controls.Label):void
    {
    	var oldValue:Object = this._1110417475label1;
        if (oldValue !== value)
        {
            this._1110417475label1 = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "label1", oldValue, value));
        }
    }



}
