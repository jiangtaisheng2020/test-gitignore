//
//  TSImageViewCell.m
//  CollectionViewDemo(照片墙)
//
//  Created by apple2015 on 16/8/11.
//  Copyright © 2016年 apple2015. All rights reserved.
//

#import "TSImageViewCell.h"
#import "UIImageView+WebCache.h"
@interface TSImageViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation TSImageViewCell

- (void)awakeFromNib {
    self.imageView.layer.borderWidth = 3;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.cornerRadius = 3;
    self.imageView.clipsToBounds = YES;
}

- (void)setImage:(NSString *)image
{
    _image=image;
    
    if([image hasPrefix:@"http"])
    {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"1"]];
        
    }else{
    
        self.imageView.image = [UIImage imageNamed:image];

    }
        
}


@end
