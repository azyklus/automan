extern "C" {
   fn jl_init();
   fn jl_atexit_hook(i: i32);
}

fn main() {
   unsafe {
      jl_init();
   }

   println!("Hello, world!");

   unsafe {
      jl_atexit_hook(0);
   }
}
