#import "TTTAttributedLabel.h"


#pragma mark - class
@class TC5ConversationView;
@class TC5Conversation;


#pragma mark - TC5ConversationViewDelegate
@protocol TC5ConversationViewDelegate <NSObject>


- (void)playButtonTouchedUpInsideWithConversationView:(UIView *)conversationView;

- (void)pickerTouchedUpInsideWithConversationView:(UIView *)conversationView
                                     conversation:(TC5Conversation *)conversation;


@end


#pragma mark - TC5ConversationView
@interface TC5ConversationView : UIView <TTTAttributedLabelDelegate> {
}


#pragma mark - property
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *conversationLabel;
@property (weak, nonatomic) IBOutlet UIView *conversationView;
@property (nonatomic, weak) id<TC5ConversationViewDelegate> delegate;
@property (strong, nonatomic) NSString *translatedText;


#pragma mark - event listener
- (IBAction)touchedUpInsideWithButton:(UIButton *)button;


#pragma mark - api
- (void)setTextWithConversation:(TC5Conversation *)conversation
                      listIndex:(NSInteger)listIndex;


@end
