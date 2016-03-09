var MyClass = (function(requiredLibraryReference) {
//requiredLibraryReference is usually $, how you want to reference the passed-in library in your class.
  "use strict";
 
  function MyClass(myPassedInVariable) {
    this.internalVariable = myPassedInVariable;
  }
 
  MyClass.classMethod = function() {
    return "I'm a class method";
  };
 
  MyClass.prototype.instanceMethod = function() {
    return "I'm an instance method";
  };
 
  MyClass.prototype.myVariable = 'foo bar';
 
  return MyClass;
})(requiredLibraryWindowInstance);
//requiredLibraryWindowInstance is usually window.jQuery, the instance of the library to pass in.
 
function ready(fn) {
  if (document.addEventListener) {
    document.addEventListener('DOMContentLoaded', fn);
  } else {
    document.attachEvent('onreadystatechange', function() {
      if (document.readyState === 'interactive')
        fn();
    });
  }
}
 
ready(function() {
  var instanceOfMyClass = new MyClass('hello world');
  instanceOfMyClass.instanceMethod();
  MyClass.classMethod();
});