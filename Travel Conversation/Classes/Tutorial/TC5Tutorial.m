/*
#import "TC5Tutorial.h"
#import "UIColor+Hexadecimal.h"
#import "MYIntroductionPanel.h"


#pragma mark - TC5Tutorial
@implementation TC5Tutorial


#pragma mark - synthesize
@synthesize introductionView;


#pragma mark - initializer
- (id)initWithParentView:(UIView *)parentView
{
    BOOL tutorialIsFinished = [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsTutorialIsFinished];
    if (tutorialIsFinished) {
        return nil;
    }

    self = [super init];
    if (self) {
        [self createTutorialWithParentView:parentView];
    }
    return self;
}


#pragma mark - dealloc
- (void)dealloc
{
   [self.introductionView removeFromSuperview];
   self.introductionView = nil;
}


#pragma mark - MYIntroduction Delegate
-(void)introduction:(MYBlurIntroductionView *)introductionView
   didChangeToPanel:(MYIntroductionPanel *)panel
          withIndex:(NSInteger)panelIndex
{
    UIColor *color = nil;
    switch (panelIndex) {
        case 0:
            color = [UIColor colorWithHexadecimal:0x3498db44];
            break;
        case 1:
            color = [UIColor colorWithHexadecimal:0x1abc9c44];
            break;
        case 2:
            color = [UIColor colorWithHexadecimal:0xe67e2244];
            break;
    }
    if (panelIndex < 3) {
        self.introductionView.BackgroundImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Tutorial_%ld.jpg", panelIndex]];
    }
    [self.introductionView setBackgroundColor:color];
}

-(void)introduction:(MYBlurIntroductionView *)introductionView
  didFinishWithType:(MYFinishType)finishType
{
    [[NSUserDefaults standardUserDefaults] setBool:YES
                                            forKey:kUserDefaultsTutorialIsFinished];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - private api
- (void)createTutorialWithParentView:(UIView *)parentView
{
    CGRect parentViewFrame = CGRectMake(0, 0, parentView.frame.size.width, parentView.frame.size.height);

    // panels
    MYIntroductionPanel *panel1 = [[MYIntroductionPanel alloc] initWithFrame:parentViewFrame
                                                                       title:@"Welcome"
                                                                 description:@""
                                                                       image:nil];

    MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithFrame:parentViewFrame
                                                                       title:@"Welcome"
                                                                 description:@""
                                                                       image:nil];

    MYIntroductionPanel *panel3 = [[MYIntroductionPanel alloc] initWithFrame:parentViewFrame
                                                                       title:@"Welcome"
                                                                 description:@""
                                                                       image:nil];

//-(id)initWithFrame:(CGRect)frame nibNamed:(NSString *)nibName
    NSArray *panels = @[panel1, panel2, panel3,];

    // introduction
    self.introductionView = [[MYBlurIntroductionView alloc] initWithFrame:parentViewFrame];
    self.introductionView.delegate = self;
    self.introductionView.BackgroundImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Tutorial_%d.jpg", 0]];;
    [self.introductionView setBackgroundColor:[UIColor colorWithHexadecimal:0x3498db44]];
    [self.introductionView buildIntroductionWithPanels:panels];
    self.introductionView.LeftSkipButton.hidden = YES;
    self.introductionView.RightSkipButton.hidden = YES;

    [parentView addSubview:self.introductionView];
}


@end
*/
