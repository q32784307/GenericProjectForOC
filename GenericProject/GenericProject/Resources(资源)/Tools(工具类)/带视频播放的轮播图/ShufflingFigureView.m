//
//  ShufflingFigureView.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/6/25.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "ShufflingFigureView.h"

@interface ShufflingFigureView ()<UIScrollViewDelegate>
{
    BOOL isReadToPlay;
    BOOL isEndPlay;
    BOOL isCliakVIew;
    NSInteger imgIndex;
}
@property(nonatomic,strong)AVPlayer *myPlayer;//播放器
@property(nonatomic,strong)AVPlayerItem *item;//播放单元
@property(nonatomic,strong)AVPlayerLayer *playerLayer;//播放界面
@property(nonatomic,strong)UIScrollView * scrolView;
@property(nonatomic,strong)UILabel *indexLab;//当前播放页数
@property(nonatomic,strong)UIButton *playBtn;//播放按钮
@property(nonatomic,strong)UIButton *videoBtn;//切换到视频
@property(nonatomic,strong)UIButton *imgBtn;//切换到图片
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)UIImageView *placeholderImg;//占位图img

@end

@implementation ShufflingFigureView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialControlUnit];
    }
    return self;
}

- (void)setWithIsVideo:(ShufflingFigureType)type andDataArray:(NSArray *)array {
    self.dataArray = array;
    
    self.scrolView.contentSize = CGSizeMake(self.dataArray.count*self.frame.size.width, self.frame.size.height);
    self.type = type;
    if (type == VideoAndImage) {
        [self.playBtn setHidden:NO];
        [self.videoBtn setHidden:NO];
        [self.imgBtn setHidden:NO];
    }else{
        [self.playBtn setHidden:YES];
        [self.videoBtn setHidden:YES];
        [self.imgBtn setHidden:YES];
    }
    for (int i = 0; i < _dataArray.count; i ++) {
        if (type == VideoAndImage) {
            if (i == 0) {
                NSURL *url = [NSURL URLWithString:self.dataArray[0]];
                self.item = [AVPlayerItem playerItemWithURL:url];
                self.myPlayer = [AVPlayer playerWithPlayerItem:self.item];
                self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.myPlayer];
                self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
                self.playerLayer.frame = CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
                [self.scrolView.layer addSublayer:self.playerLayer];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
                //通过KVO来观察status属性的变化，来获得播放之前的错误信息
                [self.item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
            }
            else{
                UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
                img.userInteractionEnabled = YES;
                [img sd_setImageWithURL:[NSURL URLWithString:self.dataArray[i]] placeholderImage:[UIImage imageNamed:@"icon_video"]];
                [self.scrolView addSubview:img];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTapClick)];
                [img addGestureRecognizer:tap];
                
                [SVProgressHUD showWithStatus:@""];
            }
            
            if (_dataArray.count > 1) {
                self.indexLab.text = [NSString stringWithFormat:@"%d/%d",1,(int)self.dataArray.count - 1];
                self.indexLab.hidden = YES;
                self.videoBtn.selected = YES;
                self.imgBtn.selected = NO;
            }
        }else{//全图片
            UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
            [img sd_setImageWithURL:[NSURL URLWithString:self.dataArray[i]] placeholderImage:[UIImage imageNamed:@"icon_video"]];
            img.userInteractionEnabled = YES;
            [self.scrolView addSubview:img];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTapClick)];
            [img addGestureRecognizer:tap];
            
            self.indexLab.text = [NSString stringWithFormat:@"%d/%d",1,(int)self.dataArray.count];
            self.indexLab.hidden = NO;
            self.videoBtn.selected = YES;
            self.imgBtn.selected = YES;
        }
    }
}

/** 视频播放结束 */
- (void)videoPlayEnd:(NSNotification *)notic {
    if (!self.myPlayer) {
        return;
    }
    [self.playBtn setSelected:NO];
    [self.playBtn setHidden:NO];
    isEndPlay = YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:
(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        //取出status的新值
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey]intValue];
        switch (status) {
            case AVPlayerItemStatusFailed:
                NSLog(@"item 有误");
                isReadToPlay = NO;
                break;
            case AVPlayerItemStatusReadyToPlay:
                NSLog(@"准好播放了");
                isReadToPlay = YES;
                [SVProgressHUD dismiss];
                break;
            case AVPlayerItemStatusUnknown:
                NSLog(@"视频资源出现未知错误");
                isReadToPlay = NO;
                break;
            default:
                break;
        }
    }
    //移除监听（观察者）
    [object removeObserver:self forKeyPath:@"status"];
}

- (void)clearCache {
    [self.playerLayer removeFromSuperlayer];
    self.playerLayer = nil;
    self.myPlayer = nil;
    [self.myPlayer replaceCurrentItemWithPlayerItem:nil];
}

#pragma mark - action
- (void)playClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (isReadToPlay) {
        if (btn.selected) {
            if (isEndPlay) {
                CGFloat a = 0;
                NSInteger dragedSeconds = floorf(a);
                CMTime dragedCMTime = CMTimeMake(dragedSeconds, 1);
                [self.myPlayer seekToTime:dragedCMTime];
                [self.myPlayer play];
                isEndPlay = NO;
            }else{
                [self.myPlayer play];
            }
        }else{
            [self.myPlayer pause];
        }
    }
}

- (void)playShowAndHidden {
    isCliakVIew = !isCliakVIew;
    if (isCliakVIew) {
        [self.playBtn setHidden:YES];
    }else{
        [self.playBtn setHidden:NO];
    }
}

- (void)changeBtnClick:(UIButton *)btn {
    if (btn.tag == 1) {
        self.videoBtn.selected = YES;
        self.imgBtn.selected = NO;
        self.videoBtn.backgroundColor = [UIColor orangeColor];
        self.imgBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
        
        if ([self.scrolView.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
            
            [self.scrolView setContentOffset:CGPointMake(0, 0) animated:NO];
            [self scrollViewDidEndDecelerating:self.scrolView];
        }
    }else{
        if (self.dataArray.count < 2) {
            return;
        }
        self.videoBtn.selected = NO;
        self.imgBtn.selected = YES;
        
        self.videoBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
        self.imgBtn.backgroundColor = [UIColor orangeColor];
        if (self.scrolView.contentOffset.x < self.frame.size.width) {
            if ([self.scrolView.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
                [self.scrolView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
                [self scrollViewDidEndDecelerating:self.scrolView];
            }
        }
    }
    return;
}

- (void)imgTapClick {
    if ([self.delegate respondsToSelector:@selector(videoView:didSelectItemAtIndexPath:)]) {
        if (self.type == VideoAndImage) {
            [self.delegate videoView:self didSelectItemAtIndexPath:imgIndex];
        }else{
            [self.delegate videoView:self didSelectItemAtIndexPath:imgIndex+1];
        }
    }
}

#pragma mark - scrollView的代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/self.bounds.size.width;
    imgIndex = index;
    if (self.type == VideoAndImage) {
        if (self.scrolView.contentOffset.x < self.frame.size.width) {
            self.indexLab.hidden = YES;
            [self.playBtn setHidden:NO];
        }
        else{
            self.indexLab.hidden = NO;
            [self.playBtn setHidden:YES];
        }
        self.indexLab.text = [NSString stringWithFormat:@"%d/%d",(int)index,(int)self.dataArray.count - 1];
    }else{
        self.indexLab.hidden = NO;
        self.indexLab.text = [NSString stringWithFormat:@"%d/%d",(int)index+1,(int)self.dataArray.count];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.type == VideoAndImage) {
        if (self.scrolView.contentOffset.x < self.frame.size.width) {
            self.videoBtn.selected = YES;
            self.imgBtn.selected = NO;
            self.videoBtn.backgroundColor = [UIColor orangeColor];
            self.imgBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
        } else{
            self.videoBtn.selected = NO;
            self.imgBtn.selected = YES;
            self.videoBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
            self.imgBtn.backgroundColor = [UIColor orangeColor];
            [self.myPlayer pause];
            [self.playBtn setSelected:NO];
        }
    }else{
        return;
    }
}

- (void)initialControlUnit {
    isEndPlay = NO;
    _scrolView = [[UIScrollView alloc]init];
    _scrolView.pagingEnabled  = YES;
    _scrolView.delegate = self;
    _scrolView.showsVerticalScrollIndicator = NO;
    _scrolView.showsHorizontalScrollIndicator = NO;
    _scrolView.userInteractionEnabled = YES;
    [self addSubview:_scrolView];
    self.scrolView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playShowAndHidden)];
    [self.scrolView addGestureRecognizer:tap];
    
    self.placeholderImg = [[UIImageView alloc]init];
    self.placeholderImg.image = [UIImage imageNamed:@"icon_play"];
    self.placeholderImg.contentMode = UIViewContentModeScaleAspectFill;
    self.placeholderImg.userInteractionEnabled = YES;
    self.placeholderImg.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.scrolView addSubview:self.placeholderImg];
    
    _playBtn = [[UIButton alloc]init];
    _playBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_playBtn setImage:[UIImage imageNamed:@"icon_video"] forState:UIControlStateNormal];
    [_playBtn setImage:[UIImage imageNamed:@"icon_play"] forState:UIControlStateSelected];
    [self addSubview:_playBtn];
    self.playBtn.frame = CGRectMake((self.frame.size.width - 60)/2.0, (self.frame.size.height - 60)/2.0, 60, 60);
    
    _indexLab = [[UILabel alloc]init];
    _indexLab.textColor = [UIColor whiteColor];
    _indexLab.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    _indexLab.font = [UIFont systemFontOfSize:11];
    _indexLab.textAlignment = 1;
    _indexLab.layer.cornerRadius = 24/2;
    _indexLab.layer.masksToBounds = YES;
    [self.indexLab setHidden:YES];
    [self addSubview:self.indexLab];
    self.indexLab.frame = CGRectMake(self.frame.size.width - 60, self.frame.size.height - 45, 50, 24);
    
    _videoBtn = [[UIButton alloc]init];
    [_videoBtn setTitle:@"视频" forState:UIControlStateNormal];
    [_videoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_videoBtn setBackgroundColor:[UIColor orangeColor]];
    _videoBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_videoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _videoBtn.layer.cornerRadius = 24/2;
    _videoBtn.layer.masksToBounds = YES;
    self.videoBtn.tag = 1;
    [self addSubview:_videoBtn];
    self.videoBtn.frame = CGRectMake(self.center.x - 70, self.frame.size.height - 45, 60, 24);
    
    _imgBtn = [[UIButton alloc]init];
    [_imgBtn setTitle:@"图片" forState:UIControlStateNormal];
    [_imgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_imgBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    _imgBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _imgBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    _imgBtn.layer.cornerRadius = 24/2;
    _imgBtn.layer.masksToBounds = YES;
    self.imgBtn.tag = 2;
    [self addSubview:_imgBtn];
    self.imgBtn.frame = CGRectMake(self.center.x + 10, self.frame.size.height - 45, 60, 24);
    
    
    [self.videoBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.imgBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.playBtn addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
