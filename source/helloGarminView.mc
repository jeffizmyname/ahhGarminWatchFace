import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;
using Toybox.Time.Gregorian as Calendar;

class helloGarminView extends WatchUi.WatchFace {
  function initialize() { WatchFace.initialize(); }

  // Load your resources here
  function onLayout(dc as Dc) as Void { setLayout(Rez.Layouts.WatchFace(dc)); }

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() as Void {}

  // Update the view
  function onUpdate(dc as Dc) as Void {
    var clockTime = System.getClockTime();
    var now = Time.now();
    var info = Calendar.info(now, Time.FORMAT_LONG);
    var timeString = Lang.format("$1$:$2$:$3$", [clockTime.hour,clockTime.min.format("%02d"),clockTime.sec.format("%02d")]); 
    var dateString = Lang.format("$1$:$2$:$3$", [info.month, info.day, info.year]);
    var infoActivity = ActivityMonitor.getInfo();
    var infoHr = ActivityMonitor.HeartRateSample;
    var hr = infoHr.heartRate;
    var steps = infoActivity.steps;
    var view = View.findDrawableById("test") as Text;
    view.setText("class Watch {\n   String time = \""+ timeString +"\"; \n  String date = \""+ dateString +"\"; \n  int steps = \""+steps+"\"; \n  int heartRate = \""+hr+"\";\n}");

    // Call the parent onUpdate function to redraw the layout
    View.onUpdate(dc);
}

// Called when this View is removed from the screen. Save the
// state of this View here. This includes freeing resources from
// memory.
function onHide() as Void {}

// The user has just looked at their watch. Timers and animations may be started
// here.
function onExitSleep() as Void {}

// Terminate any active timers and prepare for slow updates.
function onEnterSleep() as Void {}
}
