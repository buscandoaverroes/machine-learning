   * ******************************************************************** *
   *
   *       SET UP STANDARDIZATION GLOBALS AND OTHER CONSTANTS
   *
   *           - Set globals used all across the project
   *           - It is bad practice to define these at multiple locations
   *
   * ******************************************************************** *

   * ******************************************************************** *
   * Set all conversion rates used in unit standardization
   * ******************************************************************** *

   **Define all your conversion rates here instead of typing them each
   * time you are converting amounts, for example - in unit standardization.
   * We have already listed common conversion rates below, but you
   * might have to add rates specific to your project, or change the target
   * unit if you are standardizing to other units than meters, hectares,
   * and kilograms.

   *Standardizing length to meters
       global foot     = 0.3048
       global mile     = 1609.34
       global km       = 1000
       global yard     = 0.9144
       global inch     = 0.0254

   *Standardizing area to hectares
       global sqfoot   = (1 / 107639)
       global sqmile   = (1 / 258.999)
       global sqmtr    = (1 / 10000)
       global sqkmtr   = (1 / 100)
       global acre     = 0.404686

   *Standardizing weight to kilorgrams
       global pound    = 0.453592
       global gram     = 0.001
       global impTon   = 1016.05
       global usTon    = 907.1874996
       global mtrTon   = 1000

   * ******************************************************************** *
   * Set global lists of variables
   * ******************************************************************** *



   * ******************************************************************** *
   * File Paths
   * ******************************************************************** *

	


   * ******************************************************************** *
   * Anything else
   * ******************************************************************** *
