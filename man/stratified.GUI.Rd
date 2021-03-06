% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stratified.GUI.R
\name{stratified.GUI}
\alias{stratified.GUI}
\title{Graphic User Interface (GUI) for selection of stratified GRTS samples.}
\usage{
stratified.GUI()
}
\value{
A \code{SpatialDesign} (see the \code{spsurvey} package) object with
  the name specified by the user in the GUI\eqn{'}s \code{Sample\eqn{'}s R
  name} box. This object contains the sampling design specifications, the
  selected sample points in GRTS order, coordinates, and projection
  information. Sample objects are stored in the current workspace, while any
  export files, including a \code{txt} log of the commands utilized to
  generate the sample, are saved to the file directory specified via
  \code{getwd}.
  
  Any maps drawn during the sampling process must be saved before R is 
  closed. See \code{dev.copy}, \code{jpg}, and other graphics device 
  functions.
}
\description{
Initiates a dialog box via a GUI to select stratified samples 
  from 2-D resources.
}
\details{
This routine is intended to be called from the \code{SDrawNPS} menu,
  but it can also be called from the command line in non-interactive 
  environments, such as RStudio. This routine uses the \code{RGtk2} package 
  windowing capabilities to construct a pop-up dialog box, or GUI. In the 
  dialog box, users specify at least the required input parameters, then 
  press the \sQuote{Run} button to draw the sample.
  
  On submission, the GUI internally packages its inputs, processes the 
  necessary shapefile, and executes the \code{spsurvey}-package \code{grts} 
  function. All \code{SDrawNPS} GUI submissions utilizing the GRTS sampling 
  methodology lead to the creation of a text-based log file, which records 
  all code utilized. The log file thus serves as a historical record 
  containing sampling information, including the random seed utilized.  It 
  also serves as a tool for enhancing methodological understanding.
  
  See \sQuote{References} for additional resources.
}
\section{Required Inputs}{

  
  \itemize{
  
  \item{Frame Information}
  
  \enumerate{
  
  \item Select \code{GRTS} as the \sQuote{Sample Type} in the top drop-down 
  list. The other sampling types are not currently available.
  
  \item Specify the shapefile or \code{SpatialPoints*}, \code{SpatialLines*},
  or \code{SpatialPolygons*} package-\code{sp} object that constitutes the 
  sample frame in the \code{Shapefile} box, or click \sQuote{Browse} to 
  browse for a shapefile with a \code{.shp} extension. When specifying the 
  name of a shapefile via use of the input box, do not include the 
  \code{.shp} extension and recognize that all files associated with the 
  shapefile must reside in the current working directory, i.e., the one 
  returned by \code{getwd}. Following selection of a spatial object or 
  shapefile, click the \sQuote{Inspect Frame} button to plot it and list 
  variables associated with its attribute data.  This is a good way to 
  determine the study area boundary.
  
  \item Specify the name of the stratification variable. This variable must 
  be contained in the attribute data of the spatial object specified in the 
  \code{Shapefile} box. For example, this could be an elevational class 
  associated with every point in the shapefile. This name is case sensitive 
  and must match that in the shapefile or \code{sp} object exactly. Constant 
  values of this variable define the strata.
  
  \item Specify the sample\eqn{'}s R object name. The output will be a 
  \code{SpatialDesign} object created via the \code{spsurvey} package, and 
  contains the sampling design specifications and selected sample points in 
  GRTS order, along with spatial coordinates and projection information.
  
  \item Specify the \sQuote{Sample Allocation} scheme. Available options 
  include \sQuote{Proportional to Size} relative to the size of each stratum 
  in the population; \sQuote{Constant} or the same number in all strata; and 
  \sQuote{User-specified} sample sizes within each stratum. Note that units 
  in small strata will have lower probabilities of inclusion and may not be 
  represented in small overall sample sizes.
  
  \item Specify the sample size as described above for the appropriate 
  allocation scheme.
  
  }
  
  \item{Sample Allocation & Sample Size}
  
  \enumerate{
  
  \item If the allocation scheme is \sQuote{Proportional to Size,} enter one 
  number for \sQuote{Sample Size.} This number will be distributed among 
  strata based on the relative number of points, length of lines, or area of 
  polygons in each stratum.
  
  \item If the allocation scheme is \sQuote{Constant,} enter one number for 
  \sQuote{Sample Size.} This number will be selected from each stratum. For 
  example, if \code{50} is specified, 50 points will be selected from objects
  in each stratum.
  
  \item If the allocation scheme is \sQuote{User-specified,} enter a list of 
  numbers separated by commas for \sQuote{Sample Size.} If there are \eqn{H} 
  strata in the frame, specify \eqn{H} numbers, i.e., one number per stratum.
  Order of sample sizes should be the same as the levels of the 
  stratification variable, as with a factor. In fact, to match sample sizes 
  to strata, \code{SDrawNPS} calls function \code{factor} to extract factor
  levels of the strata variable. The order of these levels is the order of
  samples sizes in the list. For example, if the strata variable contains
  strings \code{"low"} and \code{"high"}, converting this variable to a
  factor generally results in alphabetic ordering of levels, as in
  \code{c("high", "low")}. In this case, the first number in the specified
  list should be the sample size in the \code{"high"} stratum. The default
  ordering of levels when vectors are converted to factors is alphabetic,
  unless global options have changed.
  
  }
  
  }
}

\section{Optional Inputs}{

  
  \enumerate{
  
  \item The \sQuote{Random number seed.} When specified, the seed may be used
  to recreate the sample. When not specified, i.e., the box is left blank, a 
  random seed is selected against the current time.  See \code{set.seed}. In 
  both cases, the seed ultimately utilized is recorded in both the resulting 
  log text file and R Console. Recording the seed allows for the easy 
  redrawing of samples if lost, or if more sites are needed. Any integer 
  value is acceptable as the random number seed.
  
  \item The number of oversample points, as encompassed via the \sQuote{Over 
  sample, each strata} box, can be specified within each stratum. Oversample 
  points are listed after the main sample points in the GRTS design file, 
  i.e., the resulting sample R output object. They can also be identified in 
  the \sQuote{panel} variable of the sample output. Apply caution when
  specifying oversample points, as large oversamples can cause samples to
  tend toward a proportional-to-size allocation even when other allocations
  are specified.
  
  }
}

\section{Dialog Buttons}{

  
  \enumerate{
  
  \item \sQuote{Inspect Frame.} After specifying the shapefile or \code{sp} 
  object name, pressing the \sQuote{Inspect Frame} button plots the 
  shapefile. It also lists the variables and their class in the
  shapefile\eqn{'}s attribute data.  After drawing a sample, the
  \sQuote{Inspect Frame} button plots the study area, along with sampled
  points.
  
  \item \sQuote{Run.} After specifying all required and optional inputs, the 
  \sQuote{Run} button draws the sample.  The \code{.GlobalEnv} workspace 
  holds the resulting \code{SpatialDesign} object with the name specified via
  the GUI \code{Sample\eqn{'}s R name} box.  A confirmation dialog appears 
  following completion of the draw. Large samples may require several tens of
  minutes for completion.
  
  \item \sQuote{Plot Sample.} Following sampling, the \sQuote{Plot Sample} 
  button displays the sampled points on the sampling frame.
  
  \item \sQuote{Tabulate Sample.} Following sampling, display the GRTS design
  file in a tabular format.  The GRTS design file contains information on 
  each sampled unit, such as coordinates, and design variables, e.g., stratum
  or multi-density category.  It also contains design weights.
  
  \item \sQuote{Export.} Following sampling, the \sQuote{Export} button 
  prompts the user to save sampling results via a pop-up dialog box. The 
  sample can be exported as an ArcGIS shapefile (\code{.SHP}); Comma 
  Separated (\code{.CSV}); Google Earth (\code{.KML}); or Garmin format 
  (\code{.GPX}) file.
  
  Shapefiles actually consist of several files with different extensions. 
  Because of this, do not include the \code{.SHP} extension in the 
  \code{Name} field of the pop-up when exporting to a shapefile.
  
  \item \sQuote{Done.} Dismisses the GUI dialog box, leaving any sample 
  objects in the \code{.GlobalEnv} workspace.
  
  }
}
\examples{
# Open a GUI for stratified GRTS sampling.
stratified.GUI()
    
}
\author{
Trent McDonald (tmcdonald@west-inc.com) and Jason Mitchell 
  (jmitchell@west-inc.com)
}
\references{
Stevens, D. L. and A. R. Olsen (2004). Spatially balanced 
  sampling of natural resources. Journal of the American Statistical 
  Association 99, 262-278.
  
  Kincaid, T. (2015). GRTS Survey Designs for an Area Resource. Accessed 
  online May 6, 2016. 
  \code{https://cran.r-project.org/web/packages/spsurvey/vignettes/Area_Design.pdf}.
  
  
  
  
  Starcevich L. A., DiDonato G., McDonald T., Mitchell, J. (2016). A GRTS 
  User\eqn{'}s Manual for the SDrawNPS Package: A graphical user interface
  for Generalized Random Tessellation Stratified (GRTS) sampling and
  estimation. National Park Service, U.S. Department of the Interior. 
  Natural Resource Report NPS/XXXX/NRR—20XX/XXX.
}
\seealso{
\code{\link{spsurvey::grts}}
}
\keyword{design}
\keyword{survey}

