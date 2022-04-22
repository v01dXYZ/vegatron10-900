.amdgcn_target "amdgcn-amd-amdhsa--gfx900" // optional
.text
.protected null_kernel
.globl null_kernel
// ignored by hipModuleGetFunction if no
// type
.type null_kernel,@function
.p2align 8

null_kernel:
	s_endpgm

// kernel definition
.section .rodata,#alloc
.p2align 6
.amdhsa_kernel null_kernel

.amdhsa_next_free_vgpr 0
.amdhsa_next_free_sgpr 0

.end_amdhsa_kernel

.section ".note.GNU-stack"
.amdgpu_metadata
---
amdhsa.kernels:
  - .group_segment_fixed_size: 0 
    .kernarg_segment_align: 8	 
    .kernarg_segment_size: 80    
    .max_flat_workgroup_size: 1024
    .name:           null_kernel
    .symbol:         null_kernel.kd
    .private_segment_fixed_size: 0 
    .sgpr_count:     18
    .vgpr_count:     9
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa--gfx900
amdhsa.version:
  - 1
  - 1
...
.end_amdgpu_metadata
