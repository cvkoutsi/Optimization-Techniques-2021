# Digital-Image-Processing-Auth-2022

This repository contains files from the 2022 project in the Digital Image Processing course of Aristotle University of Thessaloniki. The course has 3 main projects. 

# Project 1

**Rotation** \
Creates the function myImgRotation that for given image and rotation angle θ returnes the input image rotated by θ. This function uses the Bilinear Interpolation algorithm

<div id="image-table">
    <table>
	    <tr>
          <td style="padding:10px">
            	<img src="https://user-images.githubusercontent.com/95578892/230643159-ee26c200-dd48-4fb6-8041-38f75bcf7ee4.png" width="350"/>
          </td>
    	    <td style="padding:10px">
        	    <img src="https://user-images.githubusercontent.com/95578892/230643004-e869f273-d25a-4fb3-8b66-673c916d8376.png" width="350"/>
      	    </td>
        </tr>
    </table>
</div>

# Project 2- Graph Based Image Segmentation

**Image to Graph** \
Creates the function Image2Graph that for given image returns an affinity matrix that describes the image as a graph

**Graph Spectral Clustering** \
Creates the function myGraphSpectralClustering that for given input graph of an image and the number of clusters returns the labels of the clusters that each pixel belongs to 
<div id="image-table">
    <table>
	    <tr>
          <td style="padding:10px">
            	<img src="https://user-images.githubusercontent.com/95578892/230644468-8de4e44a-3a74-42fb-8452-e40b464d3df2.png" width="350"/>
          </td>
    	    <td style="padding:10px">
        	    <img src="https://user-images.githubusercontent.com/95578892/230644795-b8a42f74-b13b-4691-bb5c-3a719220d590.png" width="350"/>
      	    </td>
        </tr>
    </table>
</div>

**Normalized-cuts** \
Creates the function calculateNcut for given affinity matrix of an image and the corresponding cluster ids. This value will then be used for image clustering.

It then implements the ncuts recursive method for image clustering by:
1) Creating the k clusters for given image using the myGraphSpectralClustering function
2) Caluclating the nCutValue and
  - If the nCutValue is greater than a threshold T, it runs the above routine for each cluster
  - Otherwise, it breaks

<div id="image-table">
    <table>
	    <tr>
          <td style="padding:10px">
            	<img src="https://user-images.githubusercontent.com/95578892/230648093-cd366b66-8017-445c-855d-e10f4895c8ed.png" width="350"/>
          </td>
    	    <td style="padding:10px">
        	    <img src="https://user-images.githubusercontent.com/95578892/230648143-ce0952bd-0dc6-47b7-892b-fe65a1163481.png" width="350"/>
      	    </td>
        </tr>
    </table>
</div>

**Superpixel Segmentation** \
Implements the Simple Linear Iterative Clustering (SLIC) method that groups the pixels based on the resemblance in color and the proximity to the image level.

The algorithm of the SLIC method is already implemented in C and the method is further described in the [SLIC Superpixels](https://www.epfl.ch/labs/ivrl/research/slic-superpixels/) paper. The code returns an array the size of the image with the labels of the superpixels that each pixel belongs to.

After calculating the labels of the superpixels using the SLIC method, each superpixel is described in the superpixelDescriptor function. This function returns the RGB values of each superpixel by calculating the mean of the RGB values of every pixel belonging to the corresponding superpixel. 

The results of the above steps can be seen below:

<img width="497" alt="image" src="https://user-images.githubusercontent.com/95578892/230651206-d34f8c17-1717-4a33-8368-275244db88e9.png">
<img width="497" alt="image" src="https://user-images.githubusercontent.com/95578892/230651260-b6a607d2-3f0d-44d6-8aed-4d54c5315641.png">

# Project 3- High Dynamic Range Imaging

This project has the goal of creatining high dynamic range (HDR) images using multiple low dynamic range images (LDR) using tone mapping.

**Multi-frame HDR imaging** \
Implements the mergeLDRStack routine that given a list of LDR images, their corresponding exposure times and a weighting function returns the radiance map. The radiance map is calculated using the weighted merge of images that is HDR imaging. 

The use of this routine on a test image can be seen below:
<p>
<img src="https://user-images.githubusercontent.com/95578892/230722979-4ef032f3-3702-4308-92c1-0c87ccd01eb2.png" width="497" />
</p>

**Tone Mapping**
Creates the toneMapping function that for given radiance map and a gamma coefficient returns the toned image. The toned image is created using tone mapping that assigns the colour range of an HDR image to a limited dynamic range. 

<div id="image-table">
    <table>
	    <tr>
          <td style="padding:10px">
            	<img src="https://user-images.githubusercontent.com/95578892/230723395-47bad017-28ab-4d93-957b-7209ce3a586c.png" width="350" height="200"/>
          </td>
    	    <td style="padding:10px">
        	    <img src="https://user-images.githubusercontent.com/95578892/230723426-212d4f89-521d-46b7-a8a8-e2c1a6a7ee04.png" width="350" height="200"/>
      	    </td>
        </tr>
    </table>
</div>


**Radiometric calibration**
Creates the function estimateResponseCurve that returns the response the response curve of the cammera for the RGB channels. The inputs are:
- The stack of the LDR images
- The corresponding exposure times
- A lambda smoothing coefficient
- A weighting Function

The response curves of the RGB channels for the first image can be seen below:

<div id="image-table">
    <table>
	    <tr>
    	    <td style="padding:10px">
        	    <img src="https://user-images.githubusercontent.com/95578892/230723816-01a3eb64-0041-4924-90ff-2a7a8e6029a4.png" width="300"/>
      	    </td>
            <td style="padding:10px">
            	<img src="https://user-images.githubusercontent.com/95578892/230723829-3bc4094c-55cc-4529-864c-cf9d2cc42fe5.png" width="300"/>
            </td>
            <td style="padding:10px">
            	<img src="https://user-images.githubusercontent.com/95578892/230723837-9e24ccf2-78eb-426f-96bb-f072172c462b.png" width="300"/>
            </td>
        </tr>
    </table>
</div>
