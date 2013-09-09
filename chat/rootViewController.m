//
//  manViewController.m
//  chat
//
//  Created by 小寺 貴士 on 2012/09/10.
//  Copyright (c) 2012年 小寺 貴士. All rights reserved.
//

#import "FaceWomanViewController.h"
#import "manTableCell.h"

#import "rootViewController.h"

@interface rootViewController ()

@end

@implementation rootViewController
@synthesize select;
@synthesize huki;
int faceNum2 = 13;


//文字表示
@synthesize send;
@synthesize womanTextField;
@synthesize moji;
@synthesize rootView;
@synthesize womanTable;

//UIButton* btn;
UIImage* Face;
UIImage* huki;
UIButton* kaomoji;
FaceWomanViewController *ModalViewController;

int c22 = 0;
int c23 = 0;
int c24 = 0;
int c25 = 0;
int c26 = 0;
int c27 = 0;
int c28 = 0;
int c29 = 0;
int c30 = 0;
int c31 = 0;
int c32 = 0;
int c33 = 0;

int count21 = 0;
int count22 = 0;
int count23 = 0;
int count24 = 0;
int count25 = 0;
int count26 = 0;
int count27 = 0;
int count28 = 0;
int count29 = 0;
int count30 = 0;
int count31 = 0;
int count32 = 0;
int count33 = 0;

int mark3=0;
int up3=-4;

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
    ModalViewController  = [[FaceWomanViewController alloc] init];
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
    str = [[NSString alloc] initWithFormat:@"A:通常:%d回/喜び:%d回,変化:%d回 /安心:%d回,変化:%d回 /満足:%d回,変化:%d回 /リラックス:%d回,変化:%d回 /興奮:%d回,変化:%d回 /恐怖:%d回,変化:%d回 /驚き:%d回,変化:%d回 /不愉快:%d回,変化:%d回 /怒り:%d回,変化:%d回 /罪悪感:%d回,変化:%d回 /憂鬱:%d回,変化:%d回 /悲しみ:%d回,変化:%d回",count21,count22,c22,count23,c23,count24,c24,count25,c25,count26,c26,count27,c27,count28,c28,count29,c29,count30,c30,count31,c31,count32,c32,count33,c33];
    //str2 = [[NSString alloc] initWithFormat:@"変化させた回数/喜び:%d回,変化:%d回/安心:%d回/満足:%d回/リラックス:%d回/興奮:%d回/恐怖:%d回/驚き:%d回/不愉快:%d回/怒り:%d回/罪悪感:%d回/憂鬱:%d回/悲しみ:%d回",count22,c21,c22,c23,c24,c25,c26,c27,c28,c29,c30,c31,c32];

    [_webSocket send:str];
    //[_webSocket send:str2];
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
    [self setHuki:nil];
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
    up3++;
    mark3++;
    [celllog addObject:@"2"];
    [chatlog addObject:womanTextField.text];
    [imglog addObject:[[NSString alloc] initWithFormat:@"%d",faceNum2]];
    [womanTable reloadData];
    
    if(faceNum2==13){
        count21 = count21+1;
        mark3++;
        str = [[NSString alloc] initWithFormat:@"%@/%d/2:通常/%d回",womanTextField.text,faceNum2,count21];
    }else if(faceNum2==14){
        count22 = count22+1;
        mark3++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:喜び/2/%d回",womanTextField.text,faceNum2,count22];
    }else if(faceNum2==15){
        count23 = count23+1;
        mark3++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:安心/2/%d回",womanTextField.text,faceNum2,count23];
    }else if(faceNum2==16){
        count24 = count24+1;
        mark3++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:満足/2/%d回",womanTextField.text,faceNum2,count24];
    }else if(faceNum2==17){
        count25 = count25+1;
        mark3++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:リラックス/2/%d回",womanTextField.text,faceNum2,count25];
    }else if(faceNum2==18){
        count26 = count26+1;
        mark3++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:興奮/2/%d回",womanTextField.text,faceNum2,count26];
    }else if(faceNum2==19){
        count27 = count27+1;
        mark3++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:恐怖/2/%d回",womanTextField.text,faceNum2,count27];
    }else if(faceNum2==20){
        count28 = count28+1;
        mark3++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:驚き/2/%d回",womanTextField.text,faceNum2,count28];
    }else if(faceNum2==21){
        count29 = count29+1;
        mark3++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:不愉快/2/%d回",womanTextField.text,faceNum2,count29];
    }else if(faceNum2==22){
        count30 = count30+1;
        mark3++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:怒り/2/%d回",womanTextField.text,faceNum2,count30];
    }else if(faceNum2==23){
        count31 = count31+1;
        mark3++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:罪悪感/2/%d回",womanTextField.text,faceNum2,count31];
    }else if(faceNum2==24){
        count32 = count32+1;
        mark3++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:憂鬱/2/%d回",womanTextField.text,faceNum2,count32];
    }else if(faceNum2==25){
        count33 = count33+1;
        mark3++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:悲しみ/2/%d回",womanTextField.text,faceNum2,count33];
    }    [womanTextField resignFirstResponder];

    //    manText.frame.size.height == 35;
    int section = [womanTable numberOfSections] - 1;
    int row = [womanTable numberOfRowsInSection:section] - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [womanTable scrollToRowAtIndexPath:indexPath
                    atScrollPosition:UITableViewScrollPositionBottom
                            animated:YES];
    
    [_webSocket send:str];
    //[manTable reloadData];
    
    womanTextField.text =nil;
    [send setEnabled:NO];

    [textField resignFirstResponder];
    return YES;
}


//-- ボタンがタップされた時の処理
- (IBAction)btn:(id)sender {
    up3++;
    mark3++;
    [chatlog addObject:womanTextField.text];
    [imglog addObject:[[NSString alloc] initWithFormat:@"%d",faceNum2]];
    [celllog addObject:@"2"];
    [womanTable reloadData];
    if(faceNum2==13){
        count21 = count21+1;
        mark3++;
        str = [[NSString alloc] initWithFormat:@"%@/%d/2:通常/%d回",womanTextField.text,faceNum2,count21];
    }else if(faceNum2==14){
        count22 = count22+1;
        mark3++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:喜び/2/%d回",womanTextField.text,faceNum2,count22];

    }else if(faceNum2==15){
        count23 = count23+1;
        mark3++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:安心/2/%d回",womanTextField.text,faceNum2,count23];


    }else if(faceNum2==16){
        count24 = count24+1;
        mark3++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:満足/2/%d回",womanTextField.text,faceNum2,count24];

    }else if(faceNum2==17){
        count25 = count25+1;
        mark3++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:リラックス/2/%d回",womanTextField.text,faceNum2,count25];


    }else if(faceNum2==18){
        count26 = count26+1;
        mark3++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:興奮/2/%d回",womanTextField.text,faceNum2,count26];


    }else if(faceNum2==19){
        count27 = count27+1;
        mark3++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:恐怖/2/%d回",womanTextField.text,faceNum2,count27];

    }else if(faceNum2==20){
        count28 = count28+1;
        mark3++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:驚き/2/%d回",womanTextField.text,faceNum2,count28];
    }else if(faceNum2==21){
        count29 = count29+1;
        mark3++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:不愉快/2/%d回",womanTextField.text,faceNum2,count29];
        

    }else if(faceNum2==22){
        count30 = count30+1;
        mark3++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:怒り/2/%d回",womanTextField.text,faceNum2,count30];

    }else if(faceNum2==23){
        count31 = count31+1;
        mark3++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:罪悪感/2/%d回",womanTextField.text,faceNum2,count31];

    }else if(faceNum2==24){
        count32 = count32+1;
        mark3++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:憂鬱/2/%d回",womanTextField.text,faceNum2,count32];

    }else if(faceNum2==25){
        count33 = count33+1;
        mark3++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:悲しみ/2/%d回",womanTextField.text,faceNum2,count33];

    }
   [womanTextField resignFirstResponder];
    
    select.backgroundColor = RGB(158, 226, 90);
    huki.image = [UIImage imageNamed:@"huki12.png"];
    int section = [womanTable numberOfSections] - 1;
    int row = [womanTable numberOfRowsInSection:section] - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [womanTable scrollToRowAtIndexPath:indexPath
                    atScrollPosition:UITableViewScrollPositionBottom
                            animated:YES];
    
    [_webSocket send:str];
    //[manTable reloadData];
    
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
    CGSize size = [newcellHeight sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(140, 5000) lineBreakMode:NSLineBreakByWordWrapping];
    
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
    cell.manImage.image = [FaceWomanViewController getImage:[[imglog objectAtIndex:indexPath.row] intValue]];
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
    cell.ManLabel.lineBreakMode  = NSLineBreakByWordWrapping;
    cell.parLabel.lineBreakMode  = NSLineBreakByWordWrapping;

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
   // NSLog(@"keyboardWillShow");
    NSLog(@"mark3:%d",mark3);
    if(mark3>=8){
        NSLog(@"up3:%d",up3);
        
        float key_y = 140*up3;
        
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
    
    ModalViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ModalFace"];
    
    ModalViewController.ImageSelectdelegate_ = self;
    
}


-(void)selectImage:(int)num {
    faceNum2 = num;
    NSLog(@"%d",faceNum2);
    if (faceNum2 ==14) {
        select.text =@"喜び";
        huki.image = [UIImage imageNamed:@"huki13.png"];
         select.backgroundColor = RGB(254, 175, 220);
        c22 ++;
    }
    else if(faceNum2 ==15){
        select.text=@"安心";
        huki.image = [UIImage imageNamed:@"huki13.png"];
         select.backgroundColor = RGB(254, 175, 220);
        c23 ++;
    }else if(faceNum2 ==16){
        select.text=@"満足";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c24 ++;
    }else if(faceNum2 ==17){
        select.text=@"リラックス";
        huki.image = [UIImage imageNamed:@"huki13.png"];
         select.backgroundColor = RGB(254, 175, 220);
        c25 ++;
    }else if(faceNum2 ==18){
        select.text=@"興奮";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c26 ++;
    }else if(faceNum2 ==19){
        select.text=@"恐怖";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c27 ++;
    }else if(faceNum2 ==20){
        select.text=@"驚き";
        huki.image = [UIImage imageNamed:@"huki13.png"];
         select.backgroundColor = RGB(254, 175, 220);
        c28 ++;
    }else if(faceNum2 ==21){
        select.text=@"不愉快";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c29 ++;
    }else if(faceNum2 ==22){
        select.text=@"怒り";
        huki.image = [UIImage imageNamed:@"huki13.png"];
         select.backgroundColor = RGB(254, 175, 220);
        c30 ++;
    }else if(faceNum2 ==23){
        select.text=@"罪悪感";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c31 ++;
    }else if(faceNum2 ==24){
        select.text=@"憂鬱";
        huki.image = [UIImage imageNamed:@"huki13.png"];
         select.backgroundColor = RGB(254, 175, 220);
        c32 ++;
    }else if(faceNum2 ==25){
        select.text=@"悲しみ";
        huki.image = [UIImage imageNamed:@"huki13.png"];
         select.backgroundColor = RGB(254, 175, 220);
        c33 ++;
    }
    
}

/*-(void)currentTitle:(UIButton*)kaomoji {
    moji=kaomoji;
}*/

- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    NSLog(@"Websocket Connected");
    //[celllog addObject:@"5"];
    count21 = 0;
    count22 = 0;
    count23 = 0;
    count24 = 0;
    count25 = 0;
    count26 = 0;
    count27 = 0;
    count28 = 0;
    count29 = 0;
    count30 = 0;
    count31 = 0;
    count32 = 0;
    count33 = 0;

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
    up3++;
    mark3++;

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
