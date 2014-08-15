#import "TC5SearchTableViewCell.h"


#pragma mark - TC5PhraseTableViewCell
@interface TC5PhraseTableViewCell : TC5SearchTableViewCell {
}


#pragma mark - property
@property (nonatomic, weak) IBOutlet UILabel *categoryLabel;
@property (nonatomic, weak) IBOutlet UILabel *categoryCountLabel;
@property (nonatomic, weak) IBOutlet UIImageView *categoryImageView;


@end
