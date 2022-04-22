#include <hip/hip_runtime.h>
#include <iostream>

int main(int argc, char *argv[]) {

  hipModule_t module;

  hipError_t err_load_module = hipModuleLoad(&module, "lib_gfx900.so");

  if (err_load_module != hipSuccess) {
    std::cerr << "Could not load module" << std::endl;
    return -1;
  }

  hipFunction_t function;

  hipError_t err_get_function =
      hipModuleGetFunction(&function, module, "null_kernel");

  if (err_get_function != hipSuccess) {
    std::cerr << "Could not get symbol from module" << std::endl;
    return -1;
  }

  void *args[] = {(void *)1};

  void *size = (void *)sizeof(args);

  void *config[] = {HIP_LAUNCH_PARAM_BUFFER_POINTER, &args,
                    HIP_LAUNCH_PARAM_BUFFER_SIZE, &size, HIP_LAUNCH_PARAM_END};
  hipModuleLaunchKernel(function, 1, 1, 1, // grid dim
                        1, 1, 1,           // block dim
                        0,                 // shared size
                        NULL,              // stream
                        (void **)&config, NULL);

  hipDeviceSynchronize();

  return 0;
}
