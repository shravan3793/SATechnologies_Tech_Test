#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "logo.png" asset catalog image resource.
static NSString * const ACImageNameLogoPng AC_SWIFT_PRIVATE = @"logo.png";

#undef AC_SWIFT_PRIVATE
