//
//  XMLParserTests.m
//  RSSchool_7Tests
//
//  Created by Karina on 7/23/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XMLParser.h"

@interface XMLParser (Testing) <NSXMLParserDelegate>
- (void)resetParserState;
- (void)parserDidStartDocument:(NSXMLParser *)parser;
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
- (void)parserDidEndDocument:(NSXMLParser *)parser;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
- (void)parseVideos:(NSData *)data completion:(void (^)(NSArray<TedVideo *> *, NSError *))completion;

@property (nonatomic, strong) NSMutableDictionary *videoDictionary;
@property (nonatomic, strong) NSMutableString *parsingString;
@property (nonatomic, strong) NSMutableArray *videos;
@property (nonatomic, copy) void (^completion)(NSArray<TedVideo *> *, NSError *);
@end

@interface XMLParserTests : XCTestCase
@property (nonatomic, strong) XMLParser *parser;
@end

@implementation XMLParserTests

- (void)setUp {
    [super setUp];
    self.parser = [XMLParser new];
}

- (void)tearDown {
    [super tearDown];
    self.parser = nil;
}

- (void)test_resetParserState {
     self.parser.parsingString = [@"parsingString" mutableCopy];
     self.parser.videoDictionary = [@{ @"key1" : @"value1"} mutableCopy];
     self.parser.videos = [NSMutableArray arrayWithArray:@[@1, @2, @3]];
    
    [self.parser resetParserState];

    XCTAssertNil(self.parser.videoDictionary);
    XCTAssertNil(self.parser.parsingString);
    XCTAssertNil(self.parser.videos);
}

- (void)test_didStartDocument {
    [self.parser parserDidStartDocument:(NSXMLParser *)self.parser];
    XCTAssertNotNil(self.parser.videos);
}

- (void)test_parseErrorOccured1 {
    
    self.parser.parsingString = [@"parsingString" mutableCopy];
    self.parser.videoDictionary = [@{ @"key1" : @"value1"} mutableCopy];
    self.parser.videos = [NSMutableArray arrayWithArray:@[@1, @2, @3]];
    
    [self.parser parser:(NSXMLParser *)self.parser parseErrorOccurred:nil];
    
    XCTAssertNil(self.parser.videoDictionary);
    XCTAssertNil(self.parser.parsingString);
    XCTAssertNil(self.parser.videos);
}


- (void)test_didStartElement1 {
    [self.parser parser:(NSXMLParser *)self.parser didStartElement:@"title" namespaceURI:nil qualifiedName:nil attributes:nil];
    XCTAssertNotNil(self.parser.parsingString);
}

- (void)test_didStartElement2 {
     [self.parser parser:(NSXMLParser *)self.parser didStartElement:@"element" namespaceURI:nil qualifiedName:nil attributes:nil];
    XCTAssertNil(self.parser.parsingString);
}

- (void)test_didStartElement3 {
    [self.parser parser:(NSXMLParser *)self.parser didStartElement:@"itunes:image" namespaceURI:nil qualifiedName:nil attributes:@{@"url" : @"key1"}];
    XCTAssertTrue([self.parser.parsingString isEqualToString:@"key1"]);
}

- (void)test_didStartElement4 {
    [self.parser parser:(NSXMLParser *)self.parser didStartElement:@"item" namespaceURI:nil qualifiedName:nil attributes:@{@"url" : @"key1"}];
     XCTAssertNotNil(self.parser.videoDictionary);
}

- (void)test_didStartElement5 {
    [self.parser parser:(NSXMLParser *)self.parser didStartElement:@"itunes:duration" namespaceURI:nil qualifiedName:nil attributes:nil];
   XCTAssertNotNil(self.parser.parsingString);
}

- (void)test_didStartElement6 {
    [self.parser parser:(NSXMLParser *)self.parser didStartElement:@"media:credit" namespaceURI:nil qualifiedName:nil attributes:@{@"url" : @"key1"}];
    XCTAssertNotNil(self.parser.parsingString);
}

- (void)test_didStartElement7 {
    [self.parser parser:(NSXMLParser *)self.parser didStartElement:@"link" namespaceURI:nil qualifiedName:nil attributes:@{@"url" : @"key1"}];
    XCTAssertNotNil(self.parser.parsingString);
}

- (void)test_didStartElement8 {
    [self.parser parser:(NSXMLParser *)self.parser didStartElement:@"description" namespaceURI:nil qualifiedName:nil attributes:@{@"url" : @"key1"}];
    XCTAssertNotNil(self.parser.parsingString);
}

- (void)test_didStartElement9 {
    [self.parser parser:(NSXMLParser *)self.parser didStartElement:@"media:content" namespaceURI:nil qualifiedName:nil attributes:@{@"fileSize" : @"45513966", @"url" : @"URL"}];
   XCTAssertTrue([self.parser.parsingString isEqualToString:@"URL"]);
}

- (void)test_foundCharacters {
    self.parser.parsingString = [@"" mutableCopy];
    
    [self.parser parser:(NSXMLParser *)self.parser foundCharacters:@"characters"];
    XCTAssertNotNil(self.parser.parsingString);
     XCTAssertTrue([self.parser.parsingString isEqualToString:@"characters"]);
}

- (void)test_parserDidEndDocument {
    self.parser.parsingString = [@"parsingString" mutableCopy];
    self.parser.videoDictionary = [@{ @"key1" : @"value1"} mutableCopy];
    self.parser.videos = [NSMutableArray arrayWithArray:@[@1, @2, @3]];
    [self.parser parserDidEndDocument:(NSXMLParser *)self.parser];
    
    XCTAssertNil(self.parser.videoDictionary);
    XCTAssertNil(self.parser.parsingString);
    XCTAssertNil(self.parser.videos);
}

- (void)test_didEndElement1 {
    self.parser.parsingString = [@"parsingStringForTitle|stringToCut" mutableCopy];
    [self.parser parser:(NSXMLParser *)self.parser didEndElement:@"title" namespaceURI:nil qualifiedName:nil];
   
    XCTAssertNil(self.parser.parsingString);

}

- (void)test_didEndElement2 {
     self.parser.parsingString = [@"parsingStringForTitle2" mutableCopy];
    self.parser.videoDictionary = [@{@"title" : @"parsingStringForTitle1"} mutableCopy];
    
     [self.parser parser:(NSXMLParser *)self.parser didEndElement:@"title" namespaceURI:nil qualifiedName:nil];
    
     XCTAssertTrue([self.parser.videoDictionary isEqual:@{@"title" : @"parsingStringForTitle2 & parsingStringForTitle1"}]);
}

- (void)test_didEndElement3 {
    self.parser.videos = [NSMutableArray array];
     [self.parser parser:(NSXMLParser *)self.parser didEndElement:@"item" namespaceURI:nil qualifiedName:nil];
    
    XCTAssertNotNil(self.parser.videos);
    XCTAssertNil(self.parser.videoDictionary);
}

- (void)test_didEndElement4 {
    self.parser.parsingString = [@"00.12.50" mutableCopy];
     self.parser.videoDictionary = [@{} mutableCopy];
    [self.parser parser:(NSXMLParser *)self.parser didEndElement:@"itunes:duration" namespaceURI:nil qualifiedName:nil];
    
    XCTAssertNil(self.parser.parsingString);
    XCTAssertTrue([self.parser.videoDictionary isEqual:@{@"itunes:duration" : @"12.50"}]);
}

- (void)test_parseVideos {
    
    [self.parser parseVideos:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://translate.google.com/"]] completion:self.parser.completion];
    XCTAssertNil(self.parser.completion);
}

@end
