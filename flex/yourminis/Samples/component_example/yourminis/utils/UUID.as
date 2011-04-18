/* Copyright (c) 2007 Vlideshow.com
$Id: UUID.as 45 2007-11-14 01:05:56Z aclarke $

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

/*
** POOR MAN'S DOCUMENTATION
**
** This class implements a binary version of UUIDs as specified in the RFC:
** http://www.ietf.org/rfc/rfc4122.txt
**
** It is written in ActionScript 3.0 but should be fairly easy to get running
** in AS2.0.
**
** Given that Flash does not provide an easy way to get at some unique-space
** based identifier, this implementation does not implement Version 1 of UUIDs
** (which are 'guaranteed' to be unique in TIME and SPACE).  Instead it does a poor
** man's version of version 4 -- which means it's only as good as Flash's random
** number generator.
**
** Hopefully the package itself is fairly self-explanatory; you create UUIDs and then
** can convert them to string and from strings.  If you want to seralize one, seralize
** the string, and all "endianness" will be taken care of when you deseralize via "fromString".
**
** Given that these UUIDs are not guanaranteed unique in space (or time for that matter,
** although it's pretty unlikely you'll ever see two the same), you should take care how you use
** them.
**
** Good uses of these UUIDs
**   - You want unique ids for debugging purposes
**
** Bad uses of these UUIDs
**  - You want to use them as unique resource identifiers in your web site database.  Shame on you.
**
** If you have any questions, well, no guarantees of answers, but visit www.abclarke.com to 
** send them to me.
**
** Lastly, I'm not an ActionScript expert (this is only my 4th week of using it) so I'm sure I
** made lots of rookie mistakes.  Go easy on me.
**
** Thanks,
**
** - Art
**
*/
package yourminis.utils {
  
  import flash.utils.ByteArray;
  
  public class UUID {
    
    // These variables represent the 128 bit values of the UUID.  In flash,
    // uints are guaranteed to be 32-bit unsigned integers.  There is no
    // native unsigned 64 bit integer (signed or unsigned).  The Number class
    // represents 64 bit numbers.
    //
    // To make things 'worse', I'm not sure if Flash ensures big endian or little endian,
    // so I'm going to keep all math working at the byte level.
    
    static public function fromString(aUUID:String):UUID {
      // First, remove any non hex characters
      var uuid:String = aUUID.replace(/[^A-F,a-f,0-9]/g,"");
      
      // Now, make sure the length of the printed string is exactly
      // 32 characters long
      if (uuid.length != 32) {
        throw new ArgumentError("Invalid format for UUID {" + aUUID + "}");
      }
      
      // Now, split into 16 substrings of 2 characters each, and then convert
      // into a byte
      var byteArray:ByteArray = new ByteArray();
      
      for (var i:int = 0; i<16; i++) {
        var byteStr:String = "0x" + uuid.substr(i*2,2);
        var byte:uint = parseInt(byteStr, 16);
        byteArray[i] = byte;
      }
      
      // Now, return our UUID
      var retval:UUID = new UUID(byteArray);

      return retval;
    }
    
    static public function createRandom():UUID {
      var randomArray:ByteArray = new ByteArray();
      
      // Set to random junk first.
      // By the way, in any non-constructure you should not use stream-based
      // operations (as it changes internal data in the ByteArray.
      // However because we're in a constuctor, I'm going to cheat and use
      // the writeUnsignedInt function.
      randomArray.position = 0;
      // Write 4 unsigned int values.
      // In a perfect world this would be a much more cyrptologically sound
      // implementation, but I'm working with the tools I have.
      // Or heck, it'd be time and space based with MAC values...
      
      // And for anyone who cares, no I'm not correcting for endianess here
      // because a random bigEndian number is as good as a random littleEndian
      // number
      for (var i:uint=0;i<4;i++) {
        var randVal:uint = Math.random()*uint.MAX_VALUE;
        randomArray.writeUnsignedInt(randVal);
      }

      // Now set the right version and variant strings
      
      // First clear out the version bits
      randomArray[6] &= 0x0f;
      
      // and set to version 4, basically saying it's randomly generated
      randomArray[6] |= 0x40;
      
      // Now clear out the variant
      randomArray[8] &= 0x3f;
      
      // And set it to the IETF standard
      randomArray[8] |= 0x80;
      
      var retval:UUID = new UUID(randomArray);
      return retval;
      
    }
    
    /*
     * Here are the instance members on each UUID.  This code keeps the UUID
     * and ByteArray invariant on all future operations.
     */
    public function toString():String {
      var format:Array = new Array(4,2,2,2,6);
      var retval:String = "";
      
      // Don't use position during function methods; we want the ByteArray
      var currByte:uint = 0;
      for (var subStr:int=0; subStr < format.length; subStr++) {
        for (var i:int=0; i<format[subStr];i++ ) {
          var byte:uint = mUUID[currByte];
          retval = retval + byteToHexString(byte);
          currByte ++;
        }
        if (subStr < format.length - 1 ) {
          // We know we have at least one more subStr to go, so put
          // a delimiter
          retval = retval + "-";
        }
      }
      return retval;
    }
    
    public function compare(aUUID:UUID):int {
    
      for (var i:int=0; i<mUUID.length; i++) {
        if (this.mUUID[i] < aUUID.mUUID[i]) {
          return -1;
        } else if (this.mUUID[i] > aUUID.mUUID[i]) {
          return 1;
        }
      }
      return 0;
    }
    
    public function equals(aUUID:UUID):Boolean {
      return this.compare(aUUID) == 0;
    }
    
    /*
     * Returns the version of UUID this UUID represents.
     * For any UUIDs created from the Random UUID version
     * it'll be 4 (meaning random is as good as you'll get).
     */
    public function get version():uint {
      return ((mUUID[6] >> 4) & 0x0f);
    }
    
    /* The variant number associated with this UUID.  See the spec
     * if you don't know what a variant is.
     *
     * The variant number can be:
     * 0    Reserved for NCS backward compatibility
     * 2    The Leach-Salz variant
     * 6    Reserved, Microsoft Corporation backward compatibility
     * 7    Reserved for future definition
     */
    public function get variant():uint {
      var relevantByte:uint = mUUID[8]; // Top byte in bottom 64-bit word
      var retval:uint = 0;
      
      if ((relevantByte >> 7) == 0) {
        retval = 0;
      } else if ((relevantByte >> 6) == 2) {
        retval = 2;
      } else {
        retval = (uint) (relevantByte >> 5);
      }
      return retval;
    }
    
    /*
     * Helper internal functions and implementation details go here.
     */
     
    private var mUUID:ByteArray = null;
    
    public function UUID(aUUID:ByteArray) {
      mUUID = new ByteArray();
      var i:int=0;
      for (i=0;i<16;i++) {
        mUUID[i] = 0;
      }
    
      // We assume we're a 16-byte array
      if (aUUID == null || aUUID.length != 16) {
        throw new ArgumentError("Must be a 16-byte array");
      }
            
      for (i=0; i<aUUID.length; i++) {
        var byte:uint = aUUID[i];
        mUUID[i] = byte;
      }
    }


    static private function byteToHexString(aByte:uint):String {
      const convArray = new Array("0","1","2","3","4","5","6","7",
                                  "8","9","a","b","c","d","e","f");
      var topOctet:uint = (aByte >> 4) & 0x0f;
      var botOctet:uint = aByte &0x0f;
      return convArray[topOctet] + convArray[botOctet];
 
    }
  }
}
