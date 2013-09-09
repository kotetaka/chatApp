//
//  manViewController.m
//  chat
//
//  Created by 小寺 貴士 on 2012/09/10.
//  Copyright (c) 2012年 小寺 貴士. All rights reserved.
//

#import "PositiveWomanViewController.h"
#import "manTableCell.h"

#import "WomanViewController.h"

@interface WomanViewController ()

@end

@implementation WomanViewController
//@synthesize huki;
int c34 = 0;
int c35 = 0;
int c36 = 0;
int c37 = 0;
int c38 = 0;
int c39 = 0;
int c40 = 0;


@synthesize fuki;
int faceNum4 = 7;
int count34 = 0;
int count35 = 0;
int count36 = 0;
int count37 = 0;
int count38 = 0;
int count39 = 0;
int count40 = 0;

float key_y;
//文字表示
@synthesize select;
@synthesize send;
@synthesize womanTextField;
@synthesize moji;
@synthesize rootView;
@synthesize womanTable;

//UIButton* btn;
UIImage* Face;
UIButton* kaomoji;
PositiveWomanViewController *ModalViewController;
int mark4 =0;
int up4=-4;


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
    
    
    //ModalViewControllerの初期化
    ModalViewController  = [[PositiveWomanViewController alloc] init];
    ModalViewController.view.frame = self.view.frame;
    
    womanTextField.enablesReturnKeyAutomatically = YES;
    
    
    UIImage *bgImage = [UIImage imageNamed:@"underPageBackground.png"];
    UIImage *bgvImage = [UIImage imageNamed:@"wood.png"];
    
    chatBox.backgroundColor=[UIColor colorWithPatternImage: bgImage];
    rootView.backgroundColor=[UIColor colorWithPatternImage: bgvImage];
    
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.navigationItem.title = @"chat rooms";
    
    //chatlog初期化
    chatlog = [[NSMutableArray alloc] initWithObjects:nil];
    
    //imglog初期化
    imglog = [[NSMutableArray alloc]initWithObjects:nil];
    
    celllog = [[NSMutableArray alloc]initWithObjects:nil];
    
    womanText.delegate = self;
    
    //クリアボタンの表示
    womanTextField.clearButtonMode =UITextFieldViewModeAlways;
    
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    // キーボード表示時
    [notification addObserver:self selector:@selector(keyboardWillShow:)
						 name: UIKeyboardWillShowNotification object:nil];
    // キーボード非表示時
	[notification addObserver:self selector:@selector(keyboardWillHide:)
						 name: UIKeyboardWillHideNotification object:nil];
    
    Face = [UIImage imageNamed:@"woman.png"];
    //moji = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //  [moji setTitle:@"a" forState:UIControlStateNormal];
    
    [[select layer] setCornerRadius:12.0];
    [select setClipsToBounds:YES];
    select.text = @"通常";

    
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://192.168.1.45:3000/"]]];
    [_webSocket setDelegate:self];
    [_webSocket open];
    
    
}


- (void)viewDidUnload
{
    [self setWomanTable:nil];
    chatBox = nil;
    
    
    _webSocket.delegate = nil;
    
    [_webSocket close];
    
    [self setWomanTextField:nil];
    womanText = nil;
    [self setMoji:nil];
    [self setSend:nil];
    [self setRootView:nil];
    [self setSelect:nil];
    //[self setHuki:nil];
    [self setFuki:nil];
    [super viewDidUnload];
}

- (IBAction)editingChanged {
    
    if ([womanText.text length] != 0) {
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
    mark4++;
    up4++;
    [celllog addObject:@"2"];
    [chatlog addObject:womanTextField.text];
    [imglog addObject:[[NSString alloc] initWithFormat:@"%d",faceNum4]];
    [womanTable reloadData];
    
    if(faceNum4==7){
        count34 = count34+1;
        str = [[NSString alloc] initWithFormat:@"%@/%d:通常/2/%d回",womanTextField.text,faceNum4,count34];
        mark4 ++;
    }else if(faceNum4==8){
        count35 = count35+1;
        str = [[NSString alloc] initWithFormat:@"%@/%d:喜び/2/%d回",womanTextField.text,faceNum4,count35];
        mark4 ++;
    }else if(faceNum4==9){
        count36 = count36+1;
        mark4 ++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:安心/2/%d回",womanTextField.text,faceNum4,count36];
    }else if(faceNum4==10){
        count37 = count37+1;
        mark4 ++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:満足/2/%d回",womanTextField.text,faceNum4,count37];
    }else if(faceNum4==11){
        count38 = count38+1;
        mark4 ++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:リラックス/2/%d回",womanTextField.text,faceNum4,count38];
    }else if(faceNum4==12){
        count39 = count39+1;
        mark4 ++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:興奮/2/%d回",womanTextField.text,faceNum4,count39];
    }else if(faceNum4==13){
        count40 = count40+1;
        mark4 ++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:驚き/2/%d回",womanTextField.text,faceNum4,count40];
    }
    
    [womanTextField resignFirstResponder];

    //    manText.frame.size.height == 35;
    int section = [womanTable numberOfSections] - 1;
    int row = [womanTable numberOfRowsInSection:section] - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [womanTable scrollToRowAtIndexPath:indexPath
                      atScrollPosition:UITableViewScrollPositionBottom
                              animated:YES];
    
    [_webSocket send:str];
    //[manTable reloadData];
    
    select.text = @"通常";
    fuki.image=[UIImage imageNamed:@"huki12.png"];
    select.backgroundColor = RGB(158, 226, 90);
    
    womanTextField.text =nil;
    [send setEnabled:NO];
    
    [textField resignFirstResponder];
    return YES;
}

//背景がタップされた時の処理
- (IBAction)backgroundtap:(id)sender{
    [womanTextField resignFirstResponder];
    int section = [womanTable numberOfSections] - 1;
    int row = [womanTable numberOfRowsInSection:section] - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [womanTable scrollToRowAtIndexPath:indexPath
                    atScrollPosition:UITableViewScrollPositionBottom
                            animated:YES];

    
}

- (IBAction)total:(id)sender {
    [celllog addObject:@"5"];
    str = [[NSString alloc] initWithFormat:@"A:通常:%d回/喜び:%d回,変化:%d回 /安心:%d回,変化:%d回 /満足:%d回,変化:%d回 /リラックス:%d回,変化:%d回 /興奮:%d回,変化:%d回 /驚き:%d回,変化:%d回 ",count34,count35,c35,count36,c36,count37,c37,count38,c38,count39,c39,count40,c40];
    int section = [womanTable numberOfSections] - 1;
    int row = [womanTable numberOfRowsInSection:section] - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [womanTable scrollToRowAtIndexPath:indexPath
                      atScrollPosition:UITableViewScrollPositionBottom
                              animated:YES];

    [_webSocket send:str];
}
-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            NSLog(@"%d",buttonIndex);
            //１番目のボタンが押されたときの処理を記述する
            break;
        case 1:
            //２番目のボタンが押されたときの処理を記述する
            break;
    }
    
}

//-- ボタンがタップされた時の処理
- (IBAction)btn:(id)sender{
   /* UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"警告"
                          message:@"同じ表情を選んでいますがよろしいですか？"
                          delegate:self cancelButtonTitle:@"キャンセル"
                          otherButtonTitles:@"OK",nil];*/

    mark4++;
    up4++;
    [chatlog addObject:womanTextField.text];
    [imglog addObject:[[NSString alloc] initWithFormat:@"%d",faceNum4]];
    [celllog addObject:@"2"];
    [womanTable reloadData];
    [womanTextField resignFirstResponder];

    if(faceNum4==7){
        count34 = count34+1;
        str = [[NSString alloc] initWithFormat:@"%@/%d:通常/2/%d回",womanTextField.text,faceNum4,count34];
        mark4 ++;
    }else if(faceNum4==8){
        count35 = count35+1;
        str = [[NSString alloc] initWithFormat:@"%@/%d:喜び/2/%d回",womanTextField.text,faceNum4,count35];
        mark4 ++;

    }else if(faceNum4==9){
        count36 = count36+1;
        mark4 ++;
        str = [[NSString alloc] initWithFormat:@"%@/%d:安心/2/%d回",womanTextField.text,faceNum4,count36];

    }else if(faceNum4==10){
        count37 = count37+1;
        mark4 ++;
        str = [[NSString alloc] initWithFormat:@"%@/%d:満足/2/%d回",womanTextField.text,faceNum4,count37];
    }else if(faceNum4==11){
        count38 = count38+1;
        mark4 ++;
        str = [[NSString alloc] initWithFormat:@"%@/%d:リラックス/2/%d回",womanTextField.text,faceNum4,count38];

    }else if(faceNum4==12){
        count39 = count39+1;
        mark4 ++;
        str = [[NSString alloc] initWithFormat:@"%@/%d:興奮/2/%d回",womanTextField.text,faceNum4,count39];


    }else if(faceNum4==13){
        count40 = count40+1;
        mark4 ++;
        str = [[NSString alloc] initWithFormat:@"%@/%d:驚き/2/%d回",womanTextField.text,faceNum4,count40];
        

    }

    int section = [womanTable numberOfSections] - 1;
    int row = [womanTable numberOfRowsInSection:section] - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [womanTable scrollToRowAtIndexPath:indexPath
                      atScrollPosition:UITableViewScrollPositionBottom
                              animated:YES];
    [_webSocket send:str];

    fuki.image=[UIImage imageNamed:@"huki12.png"];
    select.backgroundColor = RGB(158, 226, 90);

    womanTextField.text =nil;
    [send setEnabled:NO];
}
;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// セクション数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//テーブルビュー
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //セルの高さをUILabelに合わせて設定
    NSString *newcellHeight = [chatlog objectAtIndex:indexPath.row];
    CGSize size = [newcellHeight sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(140, 5000) lineBreakMode:UILineBreakModeWordWrap];
    
    if(size.height-100>0){
        return size.height+54;
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
    static NSString *CustomCell = @"womanTableCell";
    
    NSLog(@"%d",[[celllog objectAtIndex:indexPath.row] intValue]);
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

    manTableCell *cell = (manTableCell*)[tableView dequeueReusableCellWithIdentifier:CustomCell];
    
    
    if (cell == nil) {
        UIViewController* vc = [[UIViewController alloc] initWithNibName:CustomCell bundle:nil];
        cell = (manTableCell*)vc;
    }
    
    NSLog(@"Face:%d",[[imglog objectAtIndex:indexPath.row] intValue]);
    cell.manImage.image = [PositiveWomanViewController getImage:[[imglog objectAtIndex:indexPath.row] intValue]];
    cell.ManLabel.text = [chatlog objectAtIndex:indexPath.row];
    
    
    cell.parLabel.text = [chatlog objectAtIndex:indexPath.row];
    
    [[cell.ManLabel layer] setCornerRadius:12.0];
    [cell.ManLabel setClipsToBounds:YES];
    
    [[cell.parLabel layer] setCornerRadius:12.0];
    [cell.parLabel setClipsToBounds:YES];
    
    //[[cell.womanLabel layer] setBorderColor:[[UIColor Color] CGColor]];
    //[[cell.womanLabel layer] setBorderWidth:1.0f];
    
    //青判定を消す
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([cell.parLabel.text length] < 17) {
        cell.parLabel.frame  = CGRectMake(644-[cell.parLabel.text length]*27,13,[cell.parLabel.text length]*27, 50);
        
        //cell.parLabel.textAlignment = UITextAlignmentRight;
    }
    else if ([cell.parLabel.text length] >= 17) {
        cell.parLabel.frame  = CGRectMake(212,13,452, 50);
        
        [cell.parLabel sizeToFit];
        
    }
    
    cell.ManLabel.frame  = CGRectMake(125, 13,452, 50);
    
    
    
    
    //改行モード（ここでは単語がおさまらなかったら単語毎改行）
    cell.ManLabel.lineBreakMode  = UILineBreakModeWordWrap;
    cell.parLabel.lineBreakMode  = UILineBreakModeWordWrap;
    
    //行数　行数制限なしにする
    cell.ManLabel.numberOfLines  = 0;
    cell.parLabel.numberOfLines  = 0;
    
    //サイズ　幅が大事（幅を指定しなかったら改行コード\nでしか改行しない）高さは後で変わるので適当。x、yはご希望の位置に
    //高さを自動で合わせる
    [cell.ManLabel sizeToFit];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


//キーボードの表示
-(void)keyboardWillShow:(NSNotification *)notificatioin 
{
    // ここでTextFieldやTextViewの位置を変更する
    NSLog(@"mark4:%d",mark4);
    if(mark4>=8){
        NSLog(@"up4:%d",up4);

        float key_y = 140*up4;
         
        CGPoint scrollPoint = CGPointMake(0.0,key_y);
        [womanTable setContentOffset:scrollPoint animated:YES];
    }
    // キーボードに合わせたアニメーション処理
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         // TextFieldのframe
                         CGRect viewRect  = chatBox.frame;
                         
                         // キーボードのサイズを取得
                         CGRect keybord;
                         [[notificatioin.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keybord];
                         
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
    // NSLog(@"keyboardWillHide");
        
    //[womanTable setContentOffset:CGPointZero animated:YES];
    
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
    
    ModalViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ModalPface"];
    
    ModalViewController.ImageSelectdelegate_ = self;
    [self presentModalViewController:ModalViewController animated:YES];
    
}


-(void)selectImage:(int)num {
    faceNum4 = num;
    
    if (faceNum4 ==8) {
        select.text =@"喜び";
        select.backgroundColor = RGB(254, 175, 220);
        fuki.image=[UIImage imageNamed:@"huki13.png"];
        c35 ++;

    }
    else if(faceNum4 ==9){
        select.text=@"安心";
       select.backgroundColor = RGB(254, 175, 220);
        fuki.image=[UIImage imageNamed:@"huki13.png"];
        c36 ++;

    }else if(faceNum4 ==10){
        select.text=@"満足";
       select.backgroundColor = RGB(254, 175, 220);
        fuki.image=[UIImage imageNamed:@"huki13.png"];
        c37 ++;

    }else if(faceNum4 ==11){
        select.text=@"リラックス";
        select.backgroundColor = RGB(254, 175, 220);
        fuki.image=[UIImage imageNamed:@"huki13.png"];
        c38 ++;

    }else if(faceNum4 ==12){
        select.text=@"興奮";
       select.backgroundColor = RGB(254, 175, 220);
        fuki.image=[UIImage imageNamed:@"huki13.png"];
        c39 ++;

    }else if(faceNum4 ==13){
        select.text=@"驚き";
       select.backgroundColor = RGB(254, 175, 220);
        fuki.image=[UIImage imageNamed:@"huki13.png"];
        c40 ++;

    }
}

/*-(void)currentTitle:(UIButton*)kaomoji {
 moji=kaomoji;
 }*/

- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    NSLog(@"Websocket Connected");
    //[celllog addObject:@"5"];
    count34 = 0;
    count35 = 0;
    count36 = 0;
    count37 = 0;
    count38 = 0;
    count39 = 0;
    count40 = 0;

    self.title = @"接続に成功しました！";
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error;
{
    NSLog(@":( Websocket Failed With Error %@", error);
    //[celllog addObject:@"5"];
    self.title = @"Connection Failed! (see logs)";
    _webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;
{
    mark4++;
    up4++;

    //messageの初期化
    NSString *mstr = [[NSString alloc] initWithFormat:@"%@",message];
    NSArray *mesArr = [mstr componentsSeparatedByString:@"/"];
    //NSLog(@"Received \"%@\"", mstr);
    [chatlog addObject:[mesArr objectAtIndex:0]];
    //img = Face;
    [imglog addObject:[mesArr objectAtIndex:1]];
    //[imglog addObject:img];
    
    [celllog addObject:[[NSString alloc] initWithFormat:@"%d", [[mesArr objectAtIndex:2] intValue]+2]];
    
    [womanTable reloadData];
    
    int section = [womanTable numberOfSections] - 1;
    int row = [womanTable numberOfRowsInSection:section] - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [womanTable scrollToRowAtIndexPath:indexPath
                      atScrollPosition:UITableViewScrollPositionMiddle
                              animated:YES];
   

}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    NSLog(@"WebSocket closed");
    self.title = @"Connection Closed! (see logs)";
    _webSocket = nil;
}


@end
