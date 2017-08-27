with System;
with Interfaces.C;

package Home_Utility.Pipes is

   type Pipe is private;
   type Get_Result is private;

   function Open_Read (Command : String) return Pipe;
   procedure Close (Stream : Pipe);

   function Get (Stream : Pipe) return Get_Result;
   function End_Of_File (Item : Get_Result) return Boolean;
   function To_Ada (Item : Get_Result) return Character;

private

   use System;
   use Interfaces.C;

   type Pipe is new Address;
   type Get_Result is new int;

end;
