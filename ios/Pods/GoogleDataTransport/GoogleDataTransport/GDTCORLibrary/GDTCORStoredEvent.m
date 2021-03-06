/*
 * Copyright 2019 Google
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <GoogleDataTransport/GDTCORStoredEvent.h>

#import <GoogleDataTransport/GDTCORClock.h>

#import "GDTCORLibrary/Private/GDTCORStorage_Private.h"

@implementation GDTCORStoredEvent

- (instancetype)initWithEvent:(GDTCOREvent *)event
                   dataFuture:(nonnull GDTCORDataFuture *)dataFuture {
  self = [super init];
  if (self) {
    _dataFuture = dataFuture;
    _mappingID = event.mappingID;
    _target = @(event.target);
    _qosTier = event.qosTier;
    _clockSnapshot = event.clockSnapshot;
    _customPrioritizationParams = event.customPrioritizationParams;
  }
  return self;
}

#pragma mark - NSSecureCoding

/** Coding key for the dataFuture ivar. */
static NSString *kDataFutureKey = @"GDTCORStoredEventDataFutureKey";

/** Coding key for mappingID ivar. */
static NSString *kMappingIDKey = @"GDTCORStoredEventMappingIDKey";

/** Coding key for target ivar. */
static NSString *kTargetKey = @"GDTCORStoredEventTargetKey";

/** Coding key for qosTier ivar. */
static NSString *kQosTierKey = @"GDTCORStoredEventQosTierKey";

/** Coding key for clockSnapshot ivar. */
static NSString *kClockSnapshotKey = @"GDTCORStoredEventClockSnapshotKey";

/** Coding key for customPrioritizationParams ivar. */
static NSString *kCustomPrioritizationParamsKey = @"GDTCORStoredEventcustomPrioritizationParamsKey";

+ (BOOL)supportsSecureCoding {
  return YES;
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
  [aCoder encodeObject:_dataFuture forKey:kDataFutureKey];
  [aCoder encodeObject:_mappingID forKey:kMappingIDKey];
  [aCoder encodeObject:_target forKey:kTargetKey];
  [aCoder encodeObject:@(_qosTier) forKey:kQosTierKey];
  [aCoder encodeObject:_clockSnapshot forKey:kClockSnapshotKey];
  [aCoder encodeObject:_customPrioritizationParams forKey:kCustomPrioritizationParamsKey];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
  self = [self init];
  if (self) {
    _dataFuture = [aDecoder decodeObjectOfClass:[GDTCORDataFuture class] forKey:kDataFutureKey];
    _mappingID = [aDecoder decodeObjectOfClass:[NSString class] forKey:kMappingIDKey];
    _target = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:kTargetKey];
    NSNumber *qosTier = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:kQosTierKey];
    _qosTier = [qosTier intValue];
    _clockSnapshot = [aDecoder decodeObjectOfClass:[GDTCORClock class] forKey:kClockSnapshotKey];
    _customPrioritizationParams = [aDecoder decodeObjectOfClass:[NSDictionary class]
                                                         forKey:kCustomPrioritizationParamsKey];
  }
  return self;
}

- (BOOL)isEqual:(GDTCORStoredEvent *)other {
  return [self hash] == [other hash];
}

- (NSUInteger)hash {
  return [_dataFuture hash] ^ [_mappingID hash] ^ [_target hash] ^ [_clockSnapshot hash] ^ _qosTier;
}

@end
