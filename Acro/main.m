//
//  main.m
//  Acro
//
//  Created by Cory D. Wiles on 1/18/12.
//  Copyright (c) 2012 VW. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kBoundaryRegex @"(\\b\\w)"
#define kRegularRegex @"(\\w)+\\s?"

static inline  NSString * acroRegex(NSString *str) {

  NSMutableString *reformatted = [[[NSMutableString alloc] init] autorelease];
  
  NSError *error = NULL;
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:kRegularRegex
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:&error];
  
  [regex enumerateMatchesInString:str options:0 range:NSMakeRange(0, [str length]) usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop){
    // Use this for regular regex
    [reformatted appendFormat:@"%@.", [[[str substringWithRange:[match range]] substringToIndex:1] uppercaseString]];

    // Use this for boundary regex
//    [reformatted appendFormat:@"%@.", [[str substringWithRange:[match range]] uppercaseString]];
  }];
  
  return reformatted;
}

static inline NSString * acroSplit(NSString *str) {
  
  NSMutableString *reformatted = [[[NSMutableString alloc] init] autorelease];
  
  NSArray *stringComponents = [str componentsSeparatedByString:@" "];
  
  [stringComponents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    NSString *currentComp = [NSString stringWithFormat:@"%@", obj];
    
    [reformatted appendFormat:@"%@.", [[currentComp substringToIndex:1] uppercaseString]];
  }];
  
  return reformatted;
}

int main (int argc, const char * argv[])
{

  @autoreleasepool {
    
    NSString *str = [NSString stringWithUTF8String:argv[1]];
    
    NSLog(@"passed in string: %@", str);
    NSLog(@"about to time regex");
    
    NSDate *acroRegexStart = [NSDate date];

//    for (int i = 0; i <= 1000; i++) {
      NSLog(@"Regex %@", acroRegex(str));
//    }
    
    NSDate *acroRegexFinish = [NSDate date];
    NSTimeInterval acroRegexExecutionTime = [acroRegexFinish timeIntervalSinceDate:acroRegexStart];
    
    NSLog(@"regex execute time: %f", acroRegexExecutionTime);

    NSLog(@"about to time split");
    
    NSDate *acroSplitStart = [NSDate date];

//    for (int i = 0; i <= 1000; i++) {
      NSLog(@"Reformatted %@", acroSplit(str));
//    }
    
    NSDate *acroSplitFinish = [NSDate date];
    NSTimeInterval acroSplitExecutionTime = [acroSplitFinish timeIntervalSinceDate:acroSplitStart];
    
    NSLog(@"split execute time: %f", acroSplitExecutionTime);
  }

  return 0;
}

