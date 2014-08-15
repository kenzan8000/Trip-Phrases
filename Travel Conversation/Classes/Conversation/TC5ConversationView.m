#import "TC5ConversationView.h"
#import <QuartzCore/QuartzCore.h>
#import "TC5Conversation.h"


#pragma mark - TC5ConversationView
@interface TC5ConversationView ()

@property (nonatomic, strong) TC5Conversation *conversation;

@end


#pragma mark - TC5ConversationView
@implementation TC5ConversationView


#pragma mark - synthesize
@synthesize conversation;
@synthesize conversationLabel;
@synthesize conversationView;
@synthesize delegate;
@synthesize translatedText;


#pragma mark - initializer
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.conversationView.layer.cornerRadius = 8;
    self.conversationView.clipsToBounds = YES;
}


#pragma mark - release
- (void)dealloc
{
    self.conversation = nil;
    self.translatedText = nil;
}


#pragma mark - TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url
{
    if ([self.delegate respondsToSelector:@selector(pickerTouchedUpInsideWithConversationView:conversation:)]) {
        [self.delegate pickerTouchedUpInsideWithConversationView:self
                                                    conversation:self.conversation];
    }
}


#pragma mark - event listener
- (IBAction)touchedUpInsideWithButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(playButtonTouchedUpInsideWithConversationView:)]) {
        [self.delegate playButtonTouchedUpInsideWithConversationView:self];
    }
}


#pragma mark - api
- (void)setTextWithConversation:(TC5Conversation *)conv
                      listIndex:(NSInteger)listIndex
{
    BOOL pickable = ([[conv translatedText] rangeOfString:@":"].length);

    self.translatedText = [conv translatedTextWithListIndex:listIndex];
    NSString *nativeText = [conv nativeTextWithListIndex:listIndex];
    if (pickable) {
        self.translatedText = [[self.translatedText componentsSeparatedByString:@":"] objectAtIndex:listIndex];
        nativeText = [[nativeText componentsSeparatedByString:@":"] objectAtIndex:listIndex];
    }

    self.conversationLabel.textColor = [UIColor darkGrayColor];
    // attribute
    [self.conversationLabel setText:@""
afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *string) {
       NSAttributedString *translatedAttributeText = [[NSAttributedString alloc] initWithString:self.translatedText
                                                                                      attributes:@{
//            NSForegroundColorAttributeName : [UIColor darkGrayColor],
                       NSFontAttributeName : [UIFont boldSystemFontOfSize:24.0f]
        }];
        NSAttributedString *nativeAttributeText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n\n%@", nativeText]
                                                                                  attributes:@{
            NSForegroundColorAttributeName : [UIColor lightGrayColor],
                       NSFontAttributeName : [UIFont boldSystemFontOfSize:12.0f]
        }];
        NSMutableAttributedString *attributedText = [NSMutableAttributedString new];
        [attributedText appendAttributedString:translatedAttributeText];
        [attributedText appendAttributedString:nativeAttributeText];
        return attributedText;
    }];

    // link
    NSArray *linkStrings = [conv replacementStringsWithListIndex:listIndex];
    if (pickable) {
        linkStrings = @[self.translatedText, nativeText];
    }
    for (NSInteger i = 0; i < linkStrings.count; i++) {
        NSString *linkString = linkStrings[i];
        NSRange linkRange = [self.conversationLabel.text rangeOfString:linkString];

        [self.conversationLabel addLinkToURL:nil
                                   withRange:linkRange];
    }

    self.conversationLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentCenter;
    self.conversationLabel.delegate = self;
    self.conversation = conv;
}


#pragma mark - private api


@end
