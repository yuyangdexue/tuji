//
//  CreateContentViewController.m
//  Trade
//
//  Created by Yuyangdexue on 15/10/30.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "CreateContentViewController.h"
#import "CreateFootView.h"
#import "CreateContentCell.h"
#import "YIPopupTextView.h"

#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>

@interface CreateContentViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,YIPopupTextViewDelegate>
{
    NSString *_albumId;
    UITableView *_tbView;
    NSMutableArray  *infoArr;
    NSMutableArray  *heightInfoArr;
    UIImagePickerController * imagePicker;
    UIImage *theImage;

}

@property (nonatomic,strong) NSString *addText;
@property (nonatomic,strong) NSString *upKey;
@end

@implementation CreateContentViewController


- (instancetype)initWithAlbumId:(NSString *)albumId
{
    self = [super init];
    if (!self) return nil;
    _albumId=albumId;
    return self;
}

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, kDeviceWidth, kDeviceHeight-50) style:UITableViewStylePlain];
        _tbView.delegate=self;
        _tbView.dataSource=self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        CreateFootView *footView=[[CreateFootView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 150)];
        _tbView.tableFooterView=footView;
        
        __weak CreateContentViewController *wealSelf=self;
        
        footView.clickPicturesBlock = ^()
        {
            [wealSelf pickImageFromAlbum];
        };
        footView.clickTextBlock = ^()
        {
            YIPopupTextView* popupTextView = [[YIPopupTextView alloc] initWithPlaceHolder:@"input here" maxCount:300];
            popupTextView.delegate = wealSelf;
            [popupTextView showInView:wealSelf.view];
        };
        //_tbView.backgroundColor=[UIColor redColor];
        
    }
    return _tbView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self changeLeftImage:nil title:@"" rightString:@"发布"];
    [self.view addSubview:self.tbView];
    infoArr=[[NSMutableArray alloc]init];
    heightInfoArr=[[NSMutableArray alloc]init];
   
}

- (void)rightClick
{
    [self httpSubmit];
}

#pragma mark tbView delegate dataSource 


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return heightInfoArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id  model=[infoArr objectAtIndex:indexPath.row];
    if ([model isKindOfClass:[UIImage class]]) {
          return [[heightInfoArr objectAtIndex:indexPath.row] floatValue]+10;
    }
    else if ([model isKindOfClass:[NSString class]])
    {
          return [[heightInfoArr objectAtIndex:indexPath.row] floatValue]+50;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellId=@"CELLID";
    CreateContentCell  *cell=[tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell=[[CreateContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    
    id  model=[infoArr objectAtIndex:indexPath.row];
    if ([model isKindOfClass:[UIImage class]]) {
          [cell resetImage:[infoArr objectAtIndex:indexPath.row]  height:[[heightInfoArr objectAtIndex:indexPath.row] floatValue]];
    }
    else if ([model isKindOfClass:[NSString class]])
    {
        [cell resetString:[infoArr objectAtIndex:indexPath.row]  height:[[heightInfoArr objectAtIndex:indexPath.row] floatValue]];
    }
    
  
    return cell;
}







#pragma mark 从用户相册获取图片

- (void)pickImageFromAlbum
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = NO;
    [self presentViewController:imagePicker animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
{
    
    NSLog(@"123123");
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"123123 Cancel");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    float height=kDeviceWidth*image.size.height/image.size.width;
    
    [infoArr addObject:image];
    [heightInfoArr addObject:[NSString stringWithFormat:@"%f",height]];
    


    theImage=image;
//    theImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(120.0, 120.0)];
    
    //[_avatarBtn setImage:theImage forState:UIControlStateNormal];
    
    NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    __weak CreateContentViewController *weakSelf=self;
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *representation = [myasset defaultRepresentation];
        NSString *fileName = [representation filename];
        NSLog(@"fileName : %@",fileName);
        weakSelf.upKey=[App getUpPhotoName:fileName];
        [weakSelf httpPicturesToken];
    };
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:imageURL
                   resultBlock:resultblock
                  failureBlock:nil];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}



#pragma mark YIPopupTextViewDelegate

- (void)popupTextView:(YIPopupTextView *)textView willDismissWithText:(NSString *)text
{
    NSLog(@"will dismiss");
    _addText=[NSString stringWithString:text];
    [infoArr addObject:text];
    CGFloat height =[self getWidth:kDeviceWidth-50 andNSString:text].height;
    [heightInfoArr addObject: [NSString stringWithFormat:@"%f",height]];
    [self httpAddText];
    
}

- (CGSize)getWidth:(float)width andNSString:(NSString *)string {
    CGSize labelSize =
    [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                         options:NSStringDrawingUsesLineFragmentOrigin
                      attributes:@{
                                   NSFontAttributeName : [UIFont systemFontOfSize:16.0]
                                   } context:nil].size;
    return labelSize;
}




- (void)popupTextView:(YIPopupTextView *)textView didDismissWithText:(NSString *)text
{
    NSLog(@"did dismiss");
}

- (void) httpSubmit
{
    if (!_albumId) {
        return;
    }
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic  setObject:_albumId forKey:@"albumId"];
    [self postRequestParam:dic AppURL:AppURL_Album_Submit isHead:YES CompleteBlock:^(NSDictionary *dic) {
        if ([dic intForKey:@"code"]==1) {
            [self showToast:@"发布成功"];
            [self popVControllerToRoot:YES];
            
        }
    } errorBlock:^(NSError *error) {
        
    }];
}


// 添加图片

- (void)httpPicturesToken
{
    if (!_albumId) {
        return;
    }
    if (!self.upKey) {
        [self showToast:@"请选择图片"];
        return;
    }
    if (!theImage) {
        [self showToast:@"请选择图片"];
        return;
    }
    [self showLoading];
    __weak CreateContentViewController *weakSelf=self;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic  setObject:_albumId forKey:@"albumId"];
    [self postRequestParam:dic AppURL:AppURL_Picture_Uploadtoken isHead:YES CompleteBlock:^(NSDictionary *dic) {
        
        if ([dic intForKey:@"code"]==1) {
            NSDictionary *data=[dic dictionaryForKey:@"data"];
            NSString *token=[data stringForKey:@"upToken"];
            NSData *imageData = UIImageJPEGRepresentation(theImage, 0.3);
            [App uploadImage:token key:self.upKey data:imageData completeBlock:^(NSDictionary *dic) {
                [weakSelf hideLoading];
                [weakSelf.tbView reloadData];
            } errorBlock:^(NSError *error) {
                [weakSelf showToast:@"图片上传失败"];
            }];
        }
        
    } errorBlock:^(NSError *error) {
        [weakSelf hideLoading];
        [weakSelf showToast:@"图片上传失败"];
    }];
    
    
}

//添加 文字
- (void)httpAddText
{
    if (!_albumId) {
        return;
    }
    if (!_addText) {
        return;
    }
    [self showLoading];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic  setObject:_albumId forKey:@"albumId"];
    [dic  setObject:_addText forKey:@"text"];
    __weak CreateContentViewController *wealSelf=self;
    [self postRequestParam:dic AppURL:AppURL_Picture_Addtext isHead:YES CompleteBlock:^(NSDictionary *dic) {
        
        if ([dic intForKey:@"code"]==1) {
            NSLog(@"文字上传成功");
             wealSelf.addText=nil;
             [self hideLoading];
            [wealSelf.tbView reloadData];
        }
        
       
        
    } errorBlock:^(NSError *error) {
         NSLog(@"文字上传失败");
        [self hideLoading];
    }];
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
