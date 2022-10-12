app=3;
all="app1 app2 app3 app4";

# echo $all | awk '{print ${!app}}';
echo $all | cut -d " " -f $app;
