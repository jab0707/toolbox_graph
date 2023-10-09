% test for computation of curvature on meshes

[vertex,face] = read_mesh('..\off\mushroom.off');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% local covariance analysis
options.covariance_smoothing = 15;
[C,U,D] = compute_mesh_local_covariance(vertex,face,vertex,options);

% options for display
tau = 1.2;
options.normal_scaling = 1.5;


options.normal = squeeze(U(:,2,:));
figure;
options.face_vertex_color = perform_saturation( -D(2,:)' - D(3,:)',tau);
plot_mesh(vertex,face, options);
shading interp; camlight; colormap jet(256);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% curvature

options.curvature_smoothing = 10;
[Umin,Umax,Cmin,Cmax,Cmean,Cgauss,Normal] = compute_curvature(vertex,face,options);

options.normal = [];
figure;
options.face_vertex_color = perform_saturation(Cmax,tau);
plot_mesh(vertex,face, options);
shading interp; camlight; colormap jet(256);

figure;
options.face_vertex_color = perform_saturation(Cmin,tau);
plot_mesh(vertex,face, options);
shading interp; camlight; colormap jet(256);

figure;
options.face_vertex_color = perform_saturation(Cmean,tau);
plot_mesh(vertex,face, options);
shading interp; camlight; colormap jet(256);

figure;
options.face_vertex_color = perform_saturation(Cgauss,tau);
plot_mesh(vertex,face, options);
shading interp; camlight; colormap jet(256);

figure;
options.face_vertex_color = perform_saturation(abs(Cmin)+abs(Cmax),tau);
plot_mesh(vertex,face, options);
shading interp; camlight; colormap jet(256);
