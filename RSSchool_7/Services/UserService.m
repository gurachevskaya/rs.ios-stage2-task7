//
//  UserService.m
//  RSSchool_7
//
//  Created by Karina on 7/19/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "UserService.h"
#import "XMLParser.h"
#import "ImageDownloadOperation.h"

@interface UserService ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) id parser;
@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) NSMutableDictionary<NSString *, NSArray<NSOperation *> *> *operations;

@end

@implementation UserService

- (instancetype)initWithParser:(id)parser {
    self = [super init];
    if (self) {
        _parser = parser;
        _queue = [NSOperationQueue new];
        _operations = [NSMutableDictionary new];
    }
    return self;
}

- (NSURLSession *)session {
    if (!_session) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return _session;
}

- (void)loadVideos:(void (^)(NSArray<TedVideo *> *, NSError *))completion {
    NSURL *url = [NSURL URLWithString:@"https://www.ted.com/themes/rss/id"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";

    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        [self.parser parseVideos:data completion:completion];
    }];

    [dataTask resume];
}

- (void)loadImageForURL:(NSString *)url completion:(void (^)(UIImage *))completion {
    [self cancelDownloadingForUrl:url];
    ImageDownloadOperation *operation = [[ImageDownloadOperation alloc] initWithUrl:url];
    self.operations[url] = @[operation];
    operation.completion = ^(UIImage *image) {
        completion(image);
    };
    [self.queue addOperation:operation];
}

- (void)cancelDownloadingForUrl:(NSString *)url {
    NSArray<NSOperation *> *operations = self.operations[url];
    if (!operations) { return; }
    for (NSOperation *operation in operations) {
        [operation cancel];
    }
}


@end
