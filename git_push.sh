#! /bin/bash

#git代码上传和更新脚本
SCRIPTS=/opt/Shell


cat <<update
echo -e "\033[31;01m"
+------------------------------------------+
+                 A) 发布                  +
+                 B) 更新                  +
+                 Q) 退出                  +
+------------------------------------------+
update
read -p "请输入 (A|B|C) ,再按ENTER键: " INPUT

# change color
echo -e "\033[32;01m"


##
if [ $INPUT = "A" ]; then
        cd $SCRIPTS
        git pull
        if [ $? -eq 0 ]; then
   		echo "GitPull更新成功！"
	fi
        echo "请输入需要上传的文件:"
        read PUSH
        echo "$PUSH"
        git add $PUSH
        if [ $?  == 0 ]; then
   		echo "正在将脚本上传到Git,请稍等..."
              #  git push origin master
        fi
        else
        	echo "发布的脚本不存在。"
        fi

