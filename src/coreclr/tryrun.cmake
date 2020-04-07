set(CROSS_ROOTFS $ENV{ROOTFS_DIR})
set(TARGET_ARCH_NAME $ENV{TARGET_BUILD_ARCH})

macro(set_cache_value)
  set(${ARGV0} ${ARGV1} CACHE STRING "Result from TRY_RUN" FORCE)
  set(${ARGV0}__TRYRUN_OUTPUT "dummy output" CACHE STRING "Output from TRY_RUN" FORCE)
endmacro()

if(EXISTS ${CROSS_ROOTFS}/usr/lib/gcc/armv6-alpine-linux-musleabihf OR
   EXISTS ${CROSS_ROOTFS}/usr/lib/gcc/aarch64-alpine-linux-musl)
  
   SET(ALPINE_LINUX 1)
else()
   SET(ALPINE_LINUX 0)
   if(EXISTS ${CROSS_ROOTFS}/bin/freebsd-version)
       set(FREEBSD 1)
       set(CMAKE_SYSTEM_NAME FreeBSD)
       set(CLR_CMAKE_TARGET_OS FreeBSD)
   else()
       SET(FREEBSD 0)
   endif()
endif()

if(TARGET_ARCH_NAME MATCHES "^(armel|arm|arm64|x86)$" OR FREEBSD)
  set_cache_value(FILE_OPS_CHECK_FERROR_OF_PREVIOUS_CALL_EXITCODE 1)
  set_cache_value(GETPWUID_R_SETS_ERRNO_EXITCODE 0)
  set_cache_value(HAS_POSIX_SEMAPHORES_EXITCODE 0)
  set_cache_value(HAVE_CLOCK_MONOTONIC_COARSE_EXITCODE 0)
  set_cache_value(HAVE_CLOCK_MONOTONIC_EXITCODE 0)
  set_cache_value(HAVE_CLOCK_THREAD_CPUTIME_EXITCODE 0)
  set_cache_value(HAVE_COMPATIBLE_ACOS_EXITCODE 0)
  set_cache_value(HAVE_COMPATIBLE_ASIN_EXITCODE 0)
  set_cache_value(HAVE_COMPATIBLE_ATAN2_EXITCODE 0)
  set_cache_value(HAVE_COMPATIBLE_ILOGB0_EXITCODE 1)
  set_cache_value(HAVE_COMPATIBLE_ILOGBNAN_EXITCODE 1)
  set_cache_value(HAVE_COMPATIBLE_LOG10_EXITCODE 0)
  set_cache_value(HAVE_COMPATIBLE_LOG_EXITCODE 0)
  set_cache_value(HAVE_COMPATIBLE_POW_EXITCODE 0)
  set_cache_value(HAVE_LARGE_SNPRINTF_SUPPORT_EXITCODE 0)
  set_cache_value(HAVE_MMAP_DEV_ZERO_EXITCODE 0)
  set_cache_value(HAVE_PROCFS_CTL_EXITCODE 1)
  set_cache_value(HAVE_PROCFS_MAPS_EXITCODE 0)
  set_cache_value(HAVE_PROCFS_STATUS_EXITCODE 0)
  set_cache_value(HAVE_PROCFS_STAT_EXITCODE 0)
  set_cache_value(HAVE_SCHED_GETCPU_EXITCODE 0)
  set_cache_value(HAVE_SCHED_GET_PRIORITY_EXITCODE 0)
  set_cache_value(HAVE_VALID_NEGATIVE_INF_POW_EXITCODE 0)
  set_cache_value(HAVE_VALID_POSITIVE_INF_POW_EXITCODE 0)
  set_cache_value(HAVE_WORKING_CLOCK_GETTIME_EXITCODE 0)
  set_cache_value(HAVE_WORKING_GETTIMEOFDAY_EXITCODE 0)
  set_cache_value(ONE_SHARED_MAPPING_PER_FILEREGION_PER_PROCESS_EXITCODE 1)
  set_cache_value(PTHREAD_CREATE_MODIFIES_ERRNO_EXITCODE 1)
  set_cache_value(REALPATH_SUPPORTS_NONEXISTENT_FILES_EXITCODE 1)
  set_cache_value(SEM_INIT_MODIFIES_ERRNO_EXITCODE 1)


  if(ALPINE_LINUX)
    set_cache_value(SSCANF_CANNOT_HANDLE_MISSING_EXPONENT_EXITCODE 0)
    set_cache_value(SSCANF_SUPPORT_ll_EXITCODE 1)
    set_cache_value(UNGETC_NOT_RETURN_EOF_EXITCODE 1)
  else()
    set_cache_value(SSCANF_CANNOT_HANDLE_MISSING_EXPONENT_EXITCODE 1)
    set_cache_value(SSCANF_SUPPORT_ll_EXITCODE 0)
    set_cache_value(UNGETC_NOT_RETURN_EOF_EXITCODE 0)
  endif()

  if (FREEBSD)
    set_cache_value(HAVE_BROKEN_FIFO_KEVENT_EXITCODE 1)
    set_cache_value(HAVE_PROCFS_MAPS 0)
    set_cache_value(HAVE_PROCFS_STAT 0)
    set_cache_value(HAVE_PROCFS_STATUS 0)
    set_cache_value(GETPWUID_R_SETS_ERRNO 0)
    set_cache_value(UNGETC_NOT_RETURN_EOF 0)
    set_cache_value(HAVE_COMPATIBLE_ILOGBNAN 1)
    set_cache_value(HAVE_FUNCTIONAL_PTHREAD_ROBUST_MUTEXES_EXITCODE 0)
  endif()
else()
  message(FATAL_ERROR "Arch is ${TARGET_ARCH_NAME}. Only armel, arm, arm64 and x86 are supported!")
endif()

if(TARGET_ARCH_NAME STREQUAL "x86")
  set_cache_value(HAVE_FUNCTIONAL_PTHREAD_ROBUST_MUTEXES_EXITCODE 0)
endif()
