//
//  FacemanViewController.m
//  chat
//
//  Created by 小寺 貴士 on 2012/09/10.
//  Copyright (c) 2012年 小寺 貴士. All rights reserved.
//

#import "FacemanViewController.h"
#import "manTableCell.h"
#import "PositiveViewController.h"

@interface FacemanViewController ()

@end



@implementation FacemanViewController


//文字表示
@synthesize huki;
@synthesize select;
@synthesize send;
@synthesize manTextField;
//@synthesize manTextField;
@synthesize rootView;

@synthesize manTable;

//@synthesize ImageSelectdelegate;

UIImage* Face;
UIButton* moji;
# define kOFFSET_FOR_KEYBOARD 150.0
PositiveViewController *ModalViewController;
int c14 = 0;
int c15 = 0;
int c16 = 0;
int c17 = 0;
int c18 = 0;
int c19 = 0;
int c20 = 0;

int faceNum3 = 0;
int count14 = 0;
int count15 = 0;
int count16 = 0;
int count17 = 0;
int count18 = 0;
int count19 = 0;
int count20 = 0;

int mark2=0;
int up2=-4;
int comment = 1;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // ソフトキーボードの表示、非表示の通知を登録する
        NSNotificationCenter *center;
        center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [center addObserver:self selector:@selector(keybaordWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [send setEnabled:NO];
    [send setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled]; //無効時
    
    [[moji layer] setCornerRadius:12.0];
    [moji setClipsToBounds:YES];
    
    UIImage *bgImage = [UIImage imageNamed:@"underPageBackground.png"];
    chatBox.backgroundColor=[UIColor colorWithPatternImage: bgImage];
    
    UIImage *bgvImage = [UIImage imageNamed:@"underPageBackground.png"];
    rootView.backgroundColor=[UIColor colorWithPatternImage: bgvImage];
    
    

    
    //ModalViewControllerの初期化
    ModalViewController  = [[PositiveViewController alloc] init];
    ModalViewController.view.frame = self.view.frame;
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.navigationItem.title = @"chat rooms";
    
    
    //chatlog初期化
    chatlog = [[NSMutableArray alloc] initWithObjects:nil];
    
    //imglog初期化
    imglog = [[NSMutableArray alloc]initWithObjects:nil];
    
    
    celllog = [[NSMutableArray alloc]initWithObjects:nil];
    
    
    manTextField.enablesReturnKeyAutomatically = YES;
    manText.delegate = self;
    
    //クリアボタンの表示
    manText.clearButtonMode =UITextFieldViewModeAlways;
    
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    // キーボード表示時
    [notification addObserver:self selector:@selector(keyboardWillShow:)
						 name: UIKeyboardWillShowNotification object:nil];
    // キーボード非表示時
	[notification addObserver:self selector:@selector(keyboardWillHide:)
						 name: UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view from its nib.
    //初期画像設定
    
    Face = [UIImage imageNamed:@"normal.png"];
    
    [[select layer] setCornerRadius:12.0];
    [select setClipsToBounds:YES];

    select.text = @"通常";
    
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://192.168.1.45:3000/"]]];
    [_webSocket setDelegate:self];
    [_webSocket open];
    
}



- (void)viewDidUnload
{
    [self setManTable:nil];
    chatBox = nil;
    
    //[self setManTextField:nil];
    
    _webSocket.delegate = nil;
    
    [_webSocket close];
    [self setSend:nil];
    [self setRootView:nil];
    
    [self setManTextField:nil];
    [self setSelect:nil];
    [self setHuki:nil];
    [super viewDidUnload];
    
    
}


//mantextの入力文字数に合わせて無効/有効 高さ調整
/*- (void) textViewDidChange: (UITextView*) textView {
 manText.enablesReturnKeyAutomatically = YES;
 
 CGRect f = manText.frame;
 
 CGRect ch = Box.frame;
 
 if ([manText.text length] >=33 && [manText.text length] == 33 ) {
 f = CGRectMake(f.origin.x, f.origin.y, f.size.width, manText.contentSize.height+15);
 manText.frame = f;
 
 ch = CGRectMake(ch.origin.x, ch.origin.y-20, ch.size.width, Box.frame.size.height+28);
 Box.frame = ch;
 
 }
 else if (manText.text == @"\n"){
 f = CGRectMake(f.origin.x, f.origin.y, f.size.width, manText.contentSize.height+15);
 manText.frame = f;
 
 ch = CGRectMake(ch.origin.x, ch.origin.y-20, ch.size.width, Box.frame.size.height+28);
 Box.frame = ch;
 
 }
 else if ([manText.text length] >=66 && [manText.text length] ==66 ) {
 f = CGRectMake(f.origin.x, f.origin.y, f.size.width, manText.contentSize.height+15);
 manText.frame = f;
 
 ch = CGRectMake(ch.origin.x, ch.origin.y-40, ch.size.width, Box.frame.size.height+54);
 Box.frame = ch;
 
 }
 
 else if( [manText.text length] <33){
 manText.frame = f;
 Box.frame = ch;
 }
 
 if ([manText.text length] != 0) {
 [send setEnabled:YES];
 [send setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; //有効時
 }
 
 else if([manText.text length] == 0){
 [send setEnabled:NO];
 [send setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled]; //無効時
 }
 }*/



- (IBAction)editingChanged {
    
    if ([manTextField.text length] != 0) {
        [send setEnabled:YES];
        [send setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; //有効時
        
    }
    else {
        [send setEnabled:NO];
        [send setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled]; //無効時
        
    }
    return;
}


//-- リターンキーがタップされたときキーボードを隠す処理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    up2++;
    mark2++;
    [celllog addObject:@"1"];
    [chatlog addObject:manTextField.text];
    [imglog addObject:[[NSString alloc] initWithFormat:@"%d",faceNum3]];
    [manTable reloadData];
    
    if(faceNum3==0){
        count14 = count14+1;
        mark2++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:通常/1/%d回",manTextField.text,faceNum3,count14];
    }else if(faceNum3==1){
        count15 = count15+1;
        mark2++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:喜び/1/%d回",manTextField.text,faceNum3,count15];
    }else if(faceNum3==2){
        count16 = count16+1;
        mark2++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:安心/1/%d回",manTextField.text,faceNum3,count16];
      //  faceNum3 =0;
    }else if(faceNum3==3){
        count17 = count17+1;
        mark2++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:満足/1/%d回",manTextField.text,faceNum3,count17];
    }else if(faceNum3==4){
        count18 = count18+1;
        mark2++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:リラックス/1/%d回",manTextField.text,faceNum3,count18];
    }else if(faceNum3==5){
        count19 = count19+1;
        mark2++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:興奮/1/%d回",manTextField.text,faceNum3,count19];
    }else if(faceNum3==6){
        count20 = count20+1;
        mark2++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:驚き/1/%d回",manTextField.text,faceNum3,count20];
    }    [manTextField resignFirstResponder];
    
    //    manText.frame.size.height == 35;
    int section = [manTable numberOfSections] - 1;
    int row = [manTable numberOfRowsInSection:section] - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [manTable scrollToRowAtIndexPath:indexPath
                    atScrollPosition:UITableViewScrollPositionBottom
                            animated:YES];
    
    [_webSocket send:str];
    //[manTable reloadData];
    
    
    
    
    /*manText.frame = CGRectMake(59, 13, 623, 35);
     
     chatBox.frame = CGRectMake(0,900,768,619);*/
    manTextField.text =nil;
    [send setEnabled:NO];
    
    return YES;
}

//背景がタップされた時の処理
- (IBAction)backgroundtap:(id)sender{
    [manTextField resignFirstResponder];
    int section = [manTable numberOfSections] - 1;
    int row = [manTable numberOfRowsInSection:section] - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [manTable scrollToRowAtIndexPath:indexPath
                    atScrollPosition:UITableViewScrollPositionBottom
                            animated:YES];

}

//-- ボタンがタップされた時の処理
- (IBAction)btn:(id)sender {
    up2++;
    mark2++;
    [celllog addObject:@"1"];
    [chatlog addObject:manTextField.text];
    [imglog addObject:[[NSString alloc] initWithFormat:@"%d",faceNum3]];
    [manTable reloadData];
    if(faceNum3==0){
        count14 = count14+1;
        mark2++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:通常/1/%d回",manTextField.text,faceNum3,count14];
    }else if(faceNum3==1){
        count15 = count15+1;
        mark2++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:喜び/1/%d回",manTextField.text,faceNum3,count15];
    }else if(faceNum3==2){
        count16 = count16+1;
        mark2++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:安心/1/%d回",manTextField.text,faceNum3,count16];
    }else if(faceNum3==3){
        count17 = count17+1;
        mark2++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:満足/1/%d回",manTextField.text,faceNum3,count17];
    }else if(faceNum3==4){
        count18 = count18+1;
        mark2++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:リラックス/1/%d回",manTextField.text,faceNum3,count18];
    }else if(faceNum3==5){
        count19 = count19+1;
        mark2++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:興奮/1/%d回",manTextField.text,faceNum3,count19];
    }else if(faceNum3==6){
        count20 = count20+1;
        mark2++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:驚き/1/%d回",manTextField.text,faceNum3,count20];
    }     [manTextField resignFirstResponder];
    
    //    manText.frame.size.height == 35;
    int section = [manTable numberOfSections] - 1;
    int row = [manTable numberOfRowsInSection:section] - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [manTable scrollToRowAtIndexPath:indexPath
                    atScrollPosition:UITableViewScrollPositionBottom
                            animated:YES];
    
    huki.image=[UIImage imageNamed:@"huki12.png"];
    select.backgroundColor = RGB(158, 226, 90);
    
    [_webSocket send:str];
    manTextField.text =nil;
    [send setEnabled:NO];
    
    
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// セクション数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    ;
}

//テーブルビュー
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //セルの高さをUILabelに合わせて設定
    NSString *newcellHeight = [chatlog objectAtIndex:indexPath.row];
    CGSize size = [newcellHeight sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(140, 5000) lineBreakMode:UILineBreakModeWordWrap];
    
    if(size.height-100>0){
        return size.height+55;
	}
    else{
        return 140;
    }
    
    
}


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [chatlog count];
    
    
}

//manTableCellを引用させる
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomCell = @"manTableCell";
    
    if ([[celllog objectAtIndex:indexPath.row] intValue] == 1) {
        CustomCell = @"manTableCell";
    }else if ([[celllog objectAtIndex:indexPath.row] intValue] == 3) {
        CustomCell = @"partnerTableCell";
        
    }else if ([[celllog objectAtIndex:indexPath.row] intValue] == 2) {
        CustomCell = @"womanTableCell";
    }else if ([[celllog objectAtIndex:indexPath.row] intValue] == 4){
        CustomCell = @"wopartnerTableCell";
    }
    else if ([[celllog objectAtIndex:indexPath.row] intValue] == 5) {
        CustomCell = @"EnterTableCell";
    }
    else if ([[celllog objectAtIndex:indexPath.row] intValue] == 6){
        CustomCell = @"RetireTableCell";
    }
    
    manTableCell* cell = (manTableCell *)[tableView dequeueReusableCellWithIdentifier:CustomCell];
    
    if (cell == nil) {
        UIViewController* vc = [[UIViewController alloc] initWithNibName:CustomCell bundle:nil];
        
        cell = (manTableCell*)vc;
    }
    
    
    cell.manImage.image = [PositiveViewController getImage:[[imglog objectAtIndex:indexPath.row] intValue]];
    cell.ManLabel.text = [chatlog objectAtIndex:indexPath.row];
    
    cell.parLabel.text = [chatlog objectAtIndex:indexPath.row];
    
    
    [[cell.ManLabel layer] setCornerRadius:12.0];
    [cell.ManLabel setClipsToBounds:YES];
    
    
    [[cell.parLabel layer] setCornerRadius:12.0];
    [cell.parLabel setClipsToBounds:YES];
    
    [[cell.enter layer] setCornerRadius:12.0];
    [cell.enter setClipsToBounds:YES];
    
    [[cell.retire layer] setCornerRadius:12.0];
    [cell.retire setClipsToBounds:YES];
    
    
    //青判定を消す
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.enter.text = @"チャットルームに入室しました";
    //  NSLog(@"%d",[cell.parLabel.text length]);
    
    
    if ([cell.parLabel.text length] < 17 ) {
        cell.parLabel.frame  = CGRectMake(644-[cell.parLabel.text length]*27,13,[cell.parLabel.text length]*27, 50);
        
        //cell.parLabel.textAlignment = UITextAlignmentRight;
    }
    /*  else if ([cell.parLabel.text length] <= 18 && @"\n") {
     cell.parLabel.frame  = CGRectMake(152,13,496, 100);
     // [cell.parLabel sizeToFit];
     //cell.parLabel.textAlignment = UITextAlignmentRight;
     }
     else if ([cell.parLabel.text length] >= 19 && @"\n") {
     cell.parLabel.frame  = CGRectMake(152,13,496, 100);
     
     //  [cell.parLabel sizeToFit];
     
     }*/
    else if ([cell.parLabel.text length] >= 17 ) {
        cell.parLabel.frame  = CGRectMake(212,13,452, 50);
        
        [cell.parLabel sizeToFit];
        
    }
    
    //NSLog(@"len:%d",[cell.parLabel.text length]);
    //[cell.parLabel setTextAlignment:UITextAlignmentRight];
    
    
    
    
    cell.ManLabel.frame  = CGRectMake(125, 13,452, 50);
    [cell.ManLabel sizeToFit];
    
    
    //改行モード（ここでは単語がおさまらなかったら単語毎改行）
    cell.ManLabel.lineBreakMode  = UILineBreakModeWordWrap;
    cell.parLabel.lineBreakMode  = UILineBreakModeWordWrap;
    
    //行数　行数制限なしにする
    cell.ManLabel.numberOfLines  = 0;
    cell.parLabel.numberOfLines  = 0;
    
    //サイズ　幅が大事（幅を指定しなかったら改行コード\nでしか改行しない）高さは後で変わるので適当。x、yはご希望の位置に
    
    //高さを自動で合わせる
    
    
    NSLog(@"Face:%d",[[imglog objectAtIndex:indexPath.row] intValue]);
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


/*- (void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    // Make changes to the view's frame inside the animation block. They will be animated instead
    // of taking place immediately.
    CGRect rect = self.view.frame;
    //CGRect manTextFieldRect = self.manTextField.frame;
    //CGRect manTableRect = self.manTable.frame;
    
    if (movedUp) {
        // If moving up, not only decrease the origin but increase the height so the view
        // covers the entire screen behind the keyboard.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        // rect.size.height += kOFFSET_FOR_KEYBOARD;
    } else {
        // If moving down, not only increase the origin but decrease the height.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        // rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    
    self.view.frame = rect;
    [UIView commitAnimations];
}*/

//キーボードの表示
-(void)keyboardWillShow:(NSNotification *)notificatioin
{
    // ここでTextFieldやTextViewの位置を変更する
    // NSLog(@"keyboardWillShow");
    NSLog(@"mark2:%d",mark2);
    if(mark2>=8){
        NSLog(@"up2:%d",up2);
        
        float key_y = 140*up2;
       
        CGPoint scrollPoint = CGPointMake(0.0,key_y);
        [manTable setContentOffset:scrollPoint animated:YES];
    }
   
    // TextFieldのframe
    
    // キーボードのサイズを取得
    CGRect keybord;
    [[notificatioin.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keybord];
        // キーボードに合わせたアニメーション処理
    [UIView animateWithDuration:0.3f
                     animations:^{
                         CGRect viewRect  = chatBox.frame;

                         
                      
                         // TextFieldの位置から(元のY座標+TextViewの高さ) - (Viewの高さ - キーボード)分、上げる(マイナスする)
                         //viewRect.origin.y -= ((266.0f+viewRect.size.height)-(self.view.frame.size.height - keybord.size.height));
                         
                         //Viewの高さ - キーボードの高さ - TextViewの高さを引いて、その位置にする
                         viewRect.origin.y = 1520 - keybord.size.height - viewRect.size.height;
                         chatBox.frame = viewRect;
                     }];
    
}

/*
 *  キーボード非表示
 */
- (void)keyboardWillHide:(NSNotification *)notificatioin
{
    // ここでTextFieldやTextViewの位置を戻す
    //  NSLog(@"keyboardWillHide");

    // キーボードに合わせたアニメーション処理
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         // TextFieldのframe
                         CGRect viewRect  = chatBox.frame;
                         
                         // TextFieldのY座標を元の位置に定義
                         viewRect.origin.y = 900.0f;
                         chatBox.frame = viewRect;
                     }];
    
}

//ModalViewの呼び出し
- (IBAction)FaceButton:(id)sender {
    
    ModalViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ModalPositive"];
    
    ModalViewController.ImageSelectdelegate_ = self;
    [self presentModalViewController:ModalViewController animated:YES];
    
}

-(void)selectImage:(int)num {
    faceNum3 = num;
    if (faceNum3 ==1) {
        select.text =@"喜び";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c15 ++;

    }
    else if(faceNum3 ==2){
        select.text=@"安心";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c16 ++;

    }else if(faceNum3 ==3){
        select.text=@"満足";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c17 ++;

    }else if(faceNum3 ==4){
        select.text=@"リラックス";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c18 ++;

    }else if(faceNum3 ==5){
        select.text=@"興奮";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c19 ++;

    }else if(faceNum3 ==6){
        select.text=@"驚き";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c20 ++;

    }
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    NSLog(@"Websocket Connected");
    //[celllog addObject:@"5"];
    count14 = 0;
    count15 = 0;
    count16 = 0;
    count17 = 0;
    count18 = 0;
    count19 = 0;
    count20 = 0;
    self.title = @"接続に成功しました!";
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error;
{
    NSLog(@":( Websocket Failed With Error %@", error);
    
    self.title = @"Connection Failed! (see logs)";
    _webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;
{
    up2++;
    mark2++;
    comment++;
    //messageの初期化
    NSString *mstr = [[NSString alloc] initWithFormat:@"%@",message];
    NSArray *mesArr = [mstr componentsSeparatedByString:@"/"];
    //NSLog(@"Received \"%@\"", mstr);
    [chatlog addObject:[mesArr objectAtIndex:0]];
    
    //img = Face;
    [imglog addObject:[mesArr objectAtIndex:1]];
    //[imglog addObject:img];
    NSLog(@"%d",[[mesArr objectAtIndex:2] intValue]+2);
    [celllog addObject:[[NSString alloc] initWithFormat:@"%d",[[mesArr objectAtIndex:2] intValue]+2]];
    [manTable reloadData];
    
            
    int section = [manTable numberOfSections] - 1;
    int row = [manTable numberOfRowsInSection:section] - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [manTable scrollToRowAtIndexPath:indexPath
                    atScrollPosition:UITableViewScrollPositionMiddle
                            animated:YES];

    
}
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    NSLog(@"WebSocket closed");
    self.title = @"Connection Closed! (see logs)";
    _webSocket = nil;
}


- (IBAction)total:(id)sender {
    str = [[NSString alloc] initWithFormat:@"A:通常:%d回/喜び:%d回,変化:%d回 /安心:%d回,変化:%d回 /満足:%d回,変化:%d回 /リラックス:%d回,変化:%d回 /興奮:%d回,変化:%d回 /驚き:%d回,変化:%d回 ",count14,count15,c15,count16,c16,count17,c17,count18,c18,count19,c19,count20,c20];
    [_webSocket send:str];
}
@end
