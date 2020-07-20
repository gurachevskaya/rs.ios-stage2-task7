//
//  XMLParser.m
//  RSSchool_7
//
//  Created by Karina on 7/18/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "XMLParser.h"

@interface XMLParser () <NSXMLParserDelegate>

@property (nonatomic, copy) void (^completion)(NSArray<TedVideo *> *, NSError *);

@property (nonatomic, strong) NSMutableDictionary *videoDictionary;
@property (nonatomic, strong) NSMutableString *parsingString;
@property (nonatomic, strong) NSMutableArray *videos;

@end

@implementation XMLParser

- (void)parseVideos:(NSData *)data completion:(void (^)(NSArray<TedVideo *> *, NSError *))completion {
    self.completion = completion;
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (self.completion) {
        self.completion(nil, parseError);
    }
    [self resetParserState];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.videos = [NSMutableArray new];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    if ([elementName isEqualToString:@"item"]) {
        self.videoDictionary = [NSMutableDictionary new];
    } else if ([elementName isEqualToString:@"title"]) {
        self.parsingString = [NSMutableString new];
    } else if ([elementName isEqualToString:@"itunes:image"]) {
        self.parsingString = [[attributeDict objectForKey:@"url"] mutableCopy];
    } else if ([elementName isEqualToString:@"itunes:duration"]) {
        self.parsingString = [NSMutableString new];
    } else if ([elementName isEqualToString:@"media:credit"]) {
        self.parsingString = [NSMutableString new];
    } else if ([elementName isEqualToString:@"description"]) {
    self.parsingString = [NSMutableString new];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.parsingString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if (self.parsingString) {
        if ([elementName isEqualToString:@"title"]) {
            NSInteger index = [self.parsingString rangeOfString:@"|"].location;
            if (index <= self.parsingString.length) {
                self.parsingString = [[self.parsingString substringToIndex:index] mutableCopy];
            }
        } else if ([elementName isEqualToString:@"itunes:duration"]) {
            if ([self.parsingString characterAtIndex:0] == '0' && [self.parsingString characterAtIndex:1] == '0') {
                self.parsingString = [[self.parsingString substringFromIndex:3] mutableCopy];
            }
        }
        if ([self.videoDictionary objectForKey:elementName] != nil) {
            self.parsingString = [[self.parsingString stringByAppendingFormat:@" & %@", [self.videoDictionary objectForKey:elementName]] mutableCopy];
        }
        [self.videoDictionary setObject:self.parsingString forKey:elementName];
        self.parsingString = nil;
    }
    
    if ([elementName isEqualToString:@"item"]) {
        TedVideo *video = [[TedVideo alloc] initWithDictionary:self.videoDictionary];
        self.videoDictionary = nil;
        [self.videos addObject:video];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (self.completion) {
        self.completion(self.videos, nil);
    }
    [self resetParserState];
}

#pragma mark - Private methods

- (void)resetParserState {
    self.completion = nil;
    self.videos = nil;
    self.videoDictionary = nil;
    self.parsingString = nil;
}

@end
