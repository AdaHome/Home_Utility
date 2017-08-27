with Ada.Assertions;

package body Home_Utility.Pipes is

   function popen (command : char_array; mode : char_array) return Address with
     Import => True,
     Convention => C,
     External_Name => "popen";

   function pclose (stream : Address) return int with
     Import => True,
     Convention => C,
     External_Name => "pclose";

   function fgetc (stream : Address) return int with
     Import => True,
     Convention => C,
     External_Name => "fgetc";

   function Open_Read (Command : String) return Pipe is
      Mode : constant char_array := "r" & nul;
      Result : Address;
   begin
      Result := popen (To_C (Command), Mode);
      Ada.Assertions.Assert (Result /= Null_Address, "popen error");
      return Pipe (Result);
   end;

   procedure Close (Stream : Pipe) is
      Result : int;
   begin
      Result := pclose (Address (Stream));
      Ada.Assertions.Assert (Result /= -1, "pclose error");
   end;

   function Get (Stream : Pipe) return Get_Result is
   begin
      return Get_Result (fgetc (Address (Stream)));
   end;

   function End_Of_File (Item : Get_Result) return Boolean is
   begin
      return Item = -1;
   end;

   function To_Ada (Item : Get_Result) return Character is
   begin
      return Character'Val (Get_Result'Pos (Item));
   end;

end;
