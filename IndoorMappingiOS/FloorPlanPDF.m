//
//  FloorPlanPDF.m
//  IndoorMappingiOS
//
//  Created by Almushigih, Hadeel on 11/20/15.
//  Copyright © 2015 Alotaibi, Waleed N. All rights reserved.
//

#import "FloorPlanPDF.h"

@implementation FloorPlanPDF
{
    CGPDFDocumentRef myDocument;
}

- (void)initPDFwithFloorNum:(int)floorNum
{
    NSString *floorNumber = @"";
    
    switch (floorNum)
    {
        case 1:
            floorNumber = @"";
            NSLog (@"First Floor");
            break;
            
        case 2:
            floorNumber = @"";
            NSLog (@"Second Floor");
            break;
            
        case 3:
            floorNumber = @"Floor_3";
            NSLog (@"Third Floor");
            break;
            
        case 4:
            floorNumber = @"";
            NSLog (@"Fourth Floor");
            break;
    }
    
    NSURL *pdfUrl = [[NSBundle mainBundle] URLForResource:floorNumber withExtension:@"pdf" subdirectory:@"FloorPlan"];
    
    [ self openPDF:pdfUrl];
    [ self selectPDFPage];
    [ self drowPDFBox];
    
}

- (void)openPDF:(NSURL*)nsurl
{
    
    CFURLRef url = (__bridge CFURLRef)nsurl;
    
    myDocument = CGPDFDocumentCreateWithURL(url);
    
    if (myDocument == NULL){
        NSLog(@"cannt open");
        CFRelease (url);
    }
   
}

- (void)selectPDFPage
{
    _PDFPage = CGPDFDocumentGetPage(myDocument, 1);
}

- (void)drowPDFBox
{
    CGPDFBox pdfBox = kCGPDFTrimBox;
    
    _PDFBoxRect = CGPDFPageGetBoxRect(_PDFPage, pdfBox);
}

@end