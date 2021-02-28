%by zhengbl
model_name = 'A2'
nf = 800;
nv = 600;
fmin = 0.01;
fmax = 1;
vmin = 2;
vmax = 9;
out = model_name;
media = load('A2.dat');

		x0= 0.0;      %useless
		y0= 1.0;      %useless
		z0 = 0.0;
		M0 = 1e20;     %useless
        rake = 45;      %useless
        dip = 45;      %useless
        str = 30;      %useless
		xs = 0.0;       %useless
		ys = 0.0;       %useless
		zs = 5;
		m = 11;        %useless
		Twin = 3000.0; %useless
		tou = 0.7;     %useless
		shift = 0.0;   %useless
		fc = 0.2;      %useless
		nlayers = size(media,1);
		h = media(:,2);
		rho = media(:,3);
		vs = media(:,4);
		vp = media(:,5);
        q1 = ones(size(vs))*500;% q value will change the width of dispersion curves
        q2 = ones(size(vp))*1000;

		file = 'grt.dat';
		fid = fopen(file,'w');
		fprintf(fid,'FOR : receiver information: rarray case:\n\n');
		% station location
		fprintf(fid,'%5.2f\n%5.2f\n%5.2f\n\n',x0,y0,z0);
		fprintf(fid,'FOR: input dat for double-couple source\n\n');
		fprintf(fid,'%5.2f\n',M0);
		fprintf(fid,'%7.5f %5.2f \n',fmin,fmax);
		fprintf(fid,' %d \n',nf);
		fprintf(fid,'%5.2f %5.2f \n',vmin,vmax);
		fprintf(fid,' %d \n',nv);
        fprintf(fid,'%5.2f %5.2f %5.2f\n',rake,dip,str)
		fprintf(fid,'%5.2f\n',xs);
		fprintf(fid,'%5.2f\n',ys);
		fprintf(fid,'%5.2f\n\n',zs);

		fprintf(fid,'FOR: basic control parameters\n\n');
		fprintf(fid,'(1). Basic control parameters\n');
		fprintf(fid,'%d\n',m);
		fprintf(fid,'%f\n\n',Twin);
		fprintf(fid,'(2).Source Typer\nE\n\n');
		fprintf(fid,'(3)Source spectral parameters\nBouchon\n\n');
		fprintf(fid,'%5.2f\n',tou);
		fprintf(fid,'%5.2f\n',shift);
		fprintf(fid,'%5.2f\n\n',fc);
		fprintf(fid,'(4).Window\nOFF\nHamming\n0.01\n0.07\n96.5\n99.3\n\n');
		fprintf(fid,'(5).Out Format\n');
		fprintf(fid,'%s\n\n',out);
		fprintf(fid,'FOR: media\n');
		fprintf(fid,'Number of total layers\n');
		fprintf(fid,'%d\n',nlayers);
		fprintf(fid,'Layer ...\n');
		for k=1:nlayers
			fprintf(fid,'%d\t%7.4f\t%7.4f\t%7.4f\t%7.4f\t%d\t%d\n',k,h(k),rho(k),vs(k),vp(k),q1(k),q2(k));
		end


		fclose(fid);
	%	eval(['!./main ',file])
%	end

!../bin/MainProgram
filename = [out,'.ds'];
f = linspace(fmin,fmax,nf);
v = linspace(vmin,vmax,nv);
tmp = load(filename);
data = reshape(tmp,nv,nf);
figure;imagesc(f,v,data);set(gca,'YDir','normal')
axis([0.01,1,2,5])
colormap(jet)
print('-dpng',[out,'.png'])
fnm = [out,'.nc'];
delete(fnm);
nccreate(fnm,'U','Dimension',{'x',length(f),'y',length(v)});
nccreate(fnm,'x','Dimension',{'x',length(f)});
nccreate(fnm,'y','Dimension',{'y',length(v)});
ncwrite(fnm,'U',data',[1 1]);
ncwrite(fnm,'x',f,1);
ncwrite(fnm,'y',v,1);

