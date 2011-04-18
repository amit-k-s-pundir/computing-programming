package f
{
  public class F
  {

    public static function map(f:Function, v:Array):Array {
      return foldr(compose(cons, f), [], v) as Array;
    }

    public static function foldl(op:Function, z:*, v:Array):* {
      if (0 == v.length)
        return z;
      return foldl(op, op(z, car(v)), cdr(v));
    }

    public static function foldr(op:Function, z:*, v:Array):* {
      if (0 == v.length)
        return z;
      return op(car(v), foldr(op, z, cdr(v)));
    }

    public static function filter(f:Function, v:Array):Array {
      var u:Array = [];
      for (var i:int = 0, n:int = v.length; i < n; ++i)
        if (f(v[i]))
          u.push(v[i]);
      return u;
    }

    public static function cons(a:*, b:*):Array { return arr(a).concat(arr(b));  }

    public static function car(v:Array):* { return v[0]; }

    public static function cdr(v:Array):Array { return v.slice(1); }

    public static function compose(func:Function, g:Function):Function {
      return function(x:*, ... args):* {
        return func.apply(null, [g(x)].concat(args));
      }
    }

    private static function arr(a:*):Array {
      if (null == a)
        a = [];
      else if (!(a is Array))
        a = [a];
      return a as Array;
    }
  }
}
  
// identity
function id(x:*):* {return x;}

// curry
function curry(f:Function):Function{
  return function(x):Function{
    return function(y) {
      return f(x,y);
    }
  }
}

// uncurry
function uncurry(f:Function):Function {
  return function(x,y){return f(x)(y);}
}

// constant function
function const(x){ return function(y){return x;} };

// procedural style foldl - uncurried
function foldl(f:Function, e:*, xs:Array):*{
  for each(var x in xs)
    e = f(e,x);
  return e;
}

// functional composition - uncurried
function o(f1:Function,f2:Function):Function {
  return function(a:*):*{
    return f1(f2(a));
  }
}

// summation - uncurried
function sum(x:Number,y:Number):Number { return x+y; }

