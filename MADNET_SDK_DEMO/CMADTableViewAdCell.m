//
//  MADTableViewCell.m
//  admee
//
//  Created by a.ivanov on 15.11.12.
//  Copyright (c) 2012 a.ivanov. All rights reserved.
//

#import "CMADTableViewAdCell.h"

@interface CMADTableViewAdCell ()
{
@private
    BOOL m_madViewIsLoaded;
    MADRotationView *m_madView;
}
@end

@implementation CMADTableViewAdCell

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self)
    {
        m_madView = [[MADRotationView alloc] initWithAdSize: kmAdSize_320x50];
#warning replace SPACE_ID with you MADNET placement id
        m_madView.spaceId = SPACE_ID;
        m_madView.transitionMask = etoAnimationOptionTransitionFlipFromTop;
        m_madViewIsLoaded = NO;
        m_madView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview: m_madView];
    }
    return (self);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        m_madView = [[MADRotationView alloc] initWithAdSize: kmAdSize_320x50];
#warning replace SPACE_ID with you MADNET placement id
        m_madView.spaceId = SPACE_ID;
        m_madViewIsLoaded = NO;
        m_madView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        
        [m_madView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self addSubview: m_madView];
    }
    return self;
}

- (void) loadMADContentWithDelegate: (id<IMADRotationViewDelegate>) aDelegate
{
    if (m_madViewIsLoaded)
    {
        return;
    }
    
    m_madView.delegate = aDelegate;
    m_madViewIsLoaded = YES;
    
    MADExternalValuesForTargeting *values = [[[MADExternalValuesForTargeting alloc] init] autorelease];
    
    [values setValue: [CMADTargetParameters params].gender.male];
    
    [m_madView loadWithExternalValues:values];
}

- (void) invalidate
{
    [m_madView invalidate];
}

- (void) dealloc
{
    [m_madView invalidate]; [m_madView release];
    m_madViewIsLoaded = NO;
    [super dealloc];
}

@end
