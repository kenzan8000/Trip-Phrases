#import "TC5SearchTableViewCell.h"


#pragma mark - class
@class TC5LaunguageTableViewCell;


#pragma mark - TC5SearchTableViewCellDelgate
@protocol TC5LaunguageTableViewCellDelegate <NSObject>


- (void)touchedUpInsideWithTC5LaunguageTableViewCell:(TC5SearchTableViewCell *)cell
                                          fromButton:(UIButton *)fromButton;

- (void)touchedUpInsideWithTC5LaunguageTableViewCell:(TC5SearchTableViewCell *)cell
                                            toButton:(UIButton *)toButton;


@end


#pragma mark - TC5LaunguageTableViewCell
@interface TC5LaunguageTableViewCell : TC5SearchTableViewCell {
}


#pragma mark - property
@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, weak) IBOutlet UILabel *fromLabel;
@property (nonatomic, weak) IBOutlet UILabel *toLabel;
@property (nonatomic, weak) IBOutlet UIButton *fromButton;
@property (nonatomic, weak) IBOutlet UIButton *toButton;
@property (nonatomic, weak) id<TC5LaunguageTableViewCellDelegate> delegate;

#pragma mark - event listener
- (IBAction)touchedUpInsideWithButton:(UIButton *)button;


@end
