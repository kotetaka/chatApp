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

#import "SRWebSocket.h"
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


@interface manViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ImageSelectDelegate,SRWebSocketDelegate>{
    
    SRWebSocket *_webSocket;
    id delegate;
   // NSArray *dataMain1;
    NSMutableArray *chatlog;
    NSMutableArray *imglog;
    NSMutableArray *celllog;
    IBOutlet UIView *chatBox;
    IBOutlet UITextField *manText;
   // NSMutableArray *Noticelog;

    UIButton *button;
    UITextField *textField;
    
    NSString *str;		// textFieldへ入力した文字を格納する変数
    UIImage *img;
}


//セル
@property (weak, nonatomic) IBOutlet UIButton *send;
@property (weak, nonatomic) IBOutlet UITextField *manTextField;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *kousin;
@property (weak, nonatomic) IBOutlet UILabel *select;

@property (strong, nonatomic) IBOutlet UIView *rootView;
//テキスト欄
@property (weak, nonatomic) IBOutlet UIImageView *huki;

//テーブル
@property (weak, nonatomic) IBOutlet UITableView *manTable;

//ModalViewの呼び出し
- (IBAction)FaceButton:(id)sender;
- (IBAction)editingChanged;
//背景がタップされた時の処理
- (IBAction)backgroundtap:(id)sender;
- (IBAction)total:(id)sender;


//- (IBAction)FaceButton:(id)sender;

//-(IBAction)backgroundTap:(id)sender;
@end
