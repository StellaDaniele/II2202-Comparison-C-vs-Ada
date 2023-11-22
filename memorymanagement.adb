with Ada.Text_IO;

procedure MemoryManagement is
   type My_Type is record
      Data : Integer;
   end record;

   procedure Use_Memory is
      Mem : My_Type;
   begin
      -- Memory is allocated on the stack
      Mem.Data := 42;
      Ada.Text_IO.Put_Line("Data: " & Mem.Data'Image);
      -- Memory is automatically reclaimed when the procedure exits
   end Use_Memory;

begin
   Use_Memory;
end MemoryManagement;