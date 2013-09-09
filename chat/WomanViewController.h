//
//  manViewController.h
//  chat
//
//  Created by 小寺 貴士 on 2012/09/10.
//  Copyright (c) 2012年 小寺 貴士. All rights reserved.
//

#import <UIKit/UIKit.h>
// 画像データを送るためのプロトコルを作る

@protocol ImageSelectDelegate
-(void)selectImage:(int)imgNum; // デリゲートメソッド
@end


/*@protocol FaceSelectDelegate
 -(void)currentTitle:(UIButton*)kaomoji forState:(UIControlState)state;// デリゲートメソッド
 @end
 */
#import "SRWebSocket.h"
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface WomanViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ImageSelectDelegate,SRWebSocketDelegate>{
    id delegate;
    SRWebSocket *_webSocket;
    IBOutlet UILabel *AlertLabel;
    // NSArray *dataMain1;
    NSMutableArray *chatlog;
    NSMutableArray *imglog;
    NSMutableArray *celllog;

    IBOutlet UIView *chatBox;
    IBOutlet UITextField *womanText;
    NSString *str;		// textFieldへ入力した文字を格納する変数
    UIImage *img;
}
@property (weak, nonatomic) IBOutlet UILabel *select;

@property (weak, nonatomic) IBOutlet UIButton *send;
//セル
@property (weak, nonatomic) IBOutlet UITextField *womanTextField;
@property (weak, nonatomic) IBOutlet UIButton *moji;

@property (weak, nonatomic) IBOutlet UIView *rootView;
//テキスト欄

@property (strong, nonatomic) IBOutlet UIImageView *fuki;

//テーブル
@property (weak, nonatomic) IBOutlet UITableView *womanTable;

//ModalViewの呼び出し
- (IBAction)FaceButton:(id)sender;
- (IBAction)editingChanged ;
- (IBAction)backgroundtap:(id)sender;
- (IBAction)total:(id)sender;



//- (IBAction)FaceButton:(id)sender;

//-(IBAction)backgroundTap:(id)sender;
@end
