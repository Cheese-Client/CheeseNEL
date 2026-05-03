@echo off
echo " ######\  ##\                                                     ##\   ##\ ########\ ##\
echo "##  __##\ ## |                                                    ###\  ## |##  _____|## |
echo "## /  \__|#######\   ######\   ######\   #######\  ######\        ####\ ## |## |      ## |
echo "## |      ##  __##\ ##  __##\ ##  __##\ ##  _____|##  __##\       ## ##\## |#####\    ## |
echo "## |      ## |  ## |######## |######## |\######\  ######## |      ## \#### |##  __|   ## |
echo "## |  ##\ ## |  ## |##   ____|##   ____| \____##\ ##   ____|      ## |\### |## |      ## |
echo "\######  |## |  ## |\#######\ \#######\ #######  |\#######\       ## | \## |########\ ########\
echo " \______/ \__|  \__| \_______| \_______|\_______/  \_______|      \__|  \__|\________|\________|
echo.

echo 请选择要连接的网易服务器：
echo 1. 布吉岛
echo 2. EC起床战争
echo 3. 梦世界
echo 4. 失落世界
echo 5. 东方大陆
echo 6. 天空之境
echo 7. 梦想世界
echo 8. 第九大陆
echo 9. MC部落
echo.

choice /c 123456789 /n /m "请输入数字 [1-9] ："

set server=
if errorlevel 9 set server=MC部落&& goto :choose_end
if errorlevel 8 set server=第九大陆&& goto :choose_end
if errorlevel 7 set server=梦想世界&& goto :choose_end
if errorlevel 6 set server=天空之境&& goto :choose_end
if errorlevel 5 set server=东方大陆&& goto :choose_end
if errorlevel 4 set server=失落世界&& goto :choose_end
if errorlevel 3 set server=梦世界&& goto :choose_end
if errorlevel 2 set server=EC起床战争 && goto :choose_end
if errorlevel 1 set server=布吉岛&& goto :choose_end

:choose_end

echo 已选择服务器：%server%
echo 正在启动脱盒，稍后%server%会出现在服务器列表...

powershell -NoProfile -ExecutionPolicy Bypass -Command "&{function w($v,$s){do{$t=$v-band0x7F;$v=$v-shr7;if($v-ne0){$t=$t-bor0x80};$s.WriteByte([byte]$t)}while($v-ne0)};$u=New-Object System.Net.Sockets.UdpClient;$u.ExclusiveAddressUse=$false;$u.Client.SetSocketOption([System.Net.Sockets.SocketOptionLevel]::Socket,[System.Net.Sockets.SocketOptionName]::ReuseAddress,$true);$u.Client.Bind([System.Net.IPEndPoint]::new([System.Net.IPAddress]::Any,0));$u.TTL=2;$u.MulticastLoopback=$true;$m=[System.Net.IPAddress]::Parse('224.0.2.60');$e=New-Object System.Net.IPEndPoint($m,4445);$l=New-Object System.Net.Sockets.TcpListener([System.Net.IPAddress]::Any,25565);$l.Start();$server='%server%';for(;;){if($l.Pending()){$c=$l.AcceptTcpClient();$s=$c.GetStream();$b=New-Object byte[] 2048;$r=0;do{$x=$s.Read($b,$r,$b.Length-$r);if($x-gt0){$r+=$x};sleep -m 10}while($s.DataAvailable -and $r -lt $b.Length);$i=0;while($i -lt $r -and ($b[$i]-band0x80)-ne0){$i++};if($i-ge$r){$c.Close();continue}$p=0;$z=0;do{$h=$b[$i++];$p=$p-bor(($h-band0x7F)-shl$z);$z+=7}while(($h-band0x80)-ne0 -and $i -lt $r);$i+=$p;if($i-ge$r){$x=$s.Read($b,$i,$b.Length-$i);if($x-le0){$c.Close();continue}$r+=$x}while($i -lt $r -and ($b[$i]-band0x80)-ne0){$i++};if($i-ge$r){$c.Close();continue}$p2=0;$z=0;do{$h=$b[$i++];$p2=$p2-bor(($h-band0x7F)-shl$z);$z+=7}while(($h-band0x80)-ne0 -and $i -lt $r);if($b[$i]-ne0){$c.Close();continue}$i++;$n=0;$z=0;do{$h=$b[$i++];$n=$n-bor(($h-band0x7F)-shl$z);$z+=7}while(($h-band0x80)-ne0 -and $i -lt $r);$pn=[System.Text.Encoding]::UTF8.GetString($b,$i,$n);$j='{\"text\":\"\",\"extra\":[{\"text\":\"§c'+$pn+' 您因 §e§l作弊§c 已被封禁 3650 天.\n\n\",\"bold\":true},{\"text\":\"§7封禁时间: §f'+(Get-Date).ToString('yyyy-MM-dd HH:mm:ss')+'\n\"},{\"text\":\"§7剩余时间: §a3649天, 23小时, 59分钟\n\"},{\"text\":\"§7如有疑问, 误封可前往256666201联系管理申诉!\"}]}';$mem=New-Object System.IO.MemoryStream;$mem.WriteByte(0);$jb=[System.Text.Encoding]::UTF8.GetBytes($j);w $jb.Length $mem;$mem.Write($jb,0,$jb.Length);$pd=$mem.ToArray();$ls=New-Object System.IO.MemoryStream;w $pd.Length $ls;$fp=$ls.ToArray()+$pd;$s.Write($fp,0,$fp.Length);$s.Flush();$c.Close()}$t='§l§eCheese§6NEL §c| §r'+$server;$pl='[MOTD]'+$t+'[/MOTD][AD]25565[/AD]';$d=[System.Text.Encoding]::UTF8.GetBytes($pl);$u.Send($d,$d.Length,$e)>$null;sleep -m 1500}}"
