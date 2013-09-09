#import "PositiveViewController.h"
#import "FacemanViewController.h"
#import "manTableCell.h"
#import "PositiveWomanViewController.h"

@interface PositiveViewController ()

@end

@implementation PositiveViewController
//@synthesize Scroll;
@synthesize face0;
@synthesize face1;
@synthesize face2;
@synthesize face3;
@synthesize face4;
@synthesize face5;


@synthesize ImageSelectdelegate_;

UIButton* FaceButton;
UIImage* manImage;

//✖ボタン
-(IBAction)modal:(id)sender {
}

//顔選択ボタン
-(IBAction)FaceSelectButton:(UIButton *)sender{
    //[sender addTarget:self action:@selector(FaceSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [ImageSelectdelegate_ selectImage:sender.tag];
}

+ (UIImage*)getImage:(int)num {
    if(num>FACE5){
        return [PositiveWomanViewController getImage:num];
    }
    else{
        
        switch(num){
            case NORMAL:
                manImage = [UIImage imageNamed:@"normal.png"];
                break;
                
            case FACE0:
                manImage = [UIImage imageNamed:@"happy.png"];
                break;
                
            case FACE1:
                manImage = [UIImage imageNamed:@"ansinman.png"];
                break;
                
            case FACE2:
                manImage = [UIImage imageNamed:@"manzokuman.png"];
                break;
                
            case FACE3:
                manImage = [UIImage imageNamed:@"rirakkusuman.png"];
                break;
                
            case FACE4:
                manImage = [UIImage imageNamed:@"kouhunman.png"];
                break;
                                
            case FACE5:
                manImage = [UIImage imageNamed:@"odorokima.png"];
                break;
          
        }
        return manImage;
    }
}

- (void)loadView {
    [super loadView];
    
}

/*- (IBAction)changePage:(id)sender {
 CGRect frame = Scroll.frame;
 frame.origin.x = frame.size.width * FaceControll.currentPage;
 frame.origin.y = 0;
 [Scroll scrollRectToVisible:frame animated:YES];
 }*/

// pageControlの左右がタップされたときに呼ばれる
// scrollViewのスクロール位置をズラして表示を変える
- (void)pageControlDidChange:(UIPageControl *)sender
{
}

// scrollViewが指で左右にスワイプされたときに呼ばれる
// pageControlの現在ページの表示位置を変更する
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    //FaceControll = nil;
    //Scroll = nil;
    //[self setScroll:nil];
    //[self setFaceControll:nil];
    
    [super viewDidUnload];
    face0 = nil;
    face1 = nil;
    face2 = nil;
    face3 = nil;
    face4 = nil;
    face5 = nil;
 
    
    self.ImageSelectdelegate_ = nil;
    //ナビゲーションバーを隠す
    
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}





@end
