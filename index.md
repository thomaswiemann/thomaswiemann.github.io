---
layout: default
title: Home
group: "navigation"
order: 1
summary: I'm Thomas Wiemann, Postdoctoral Scholar in Marketing at the University of Chicago Booth School of Business. I'm on the 2025-26 academic job market! 
---
<br><br>

<div class="intro-container">
    <div class="intro-image">
        <img src="/assets/images/jm_portrait_540.jpg" alt="Thomas Wiemann" style="width: 140px;">
    </div>
    <div class="intro-text">
        <h1 style="margin-top: 0;">Thomas Wiemann</h1>
        Welcome! I'm a Postdoctoral Scholar at the University of Chicago Booth School of Business. My research interests lie in the intersection of marketing, econometrics, and machine learning/AI.
        
        <p></p>
        <a href="mailto:thomas.wiemann@chicagobooth.edu">thomas.wiemann@chicagobooth.edu</a>
        <p><img src="/assets/images/GitHub-Mark-32px.png" alt="GitHub Icon" style="width:20px"> <a href="https://github.com/thomaswiemann">@thomaswiemann</a> </p>
  
    </div>
</div>


<!-- <br> -->



## Working papers

**Personalization with HART** \
 [<a style="cursor:pointer;" onclick="toggleVisibility('abstract_HART');">abstract</a>; [draft](assets/pdfs/jmp_wiemann.pdf); [R package](https://thomaswiemann.com/bayesm.HART/)].
<div id="abstract_HART" style="display:none;">
Firms personalize prices, advertising, product design, and more to find and serve their---often highly heterogeneous---consumers. When personalizing to *known* consumers, these marketing decisions can be informed by past choice behavior. However, firms must rely on observed characteristics for *new* consumers with limited or no purchase histories. Existing methods are tailored for either new or known consumers, complicating personalization both across and within consumers. I propose Bayesian *hierarchical* additive regression trees (HART) to define optimal marketing decisions that adapt to the firm's familiarity with the consumer. HART combines the strengths of supervised machine learning and hierarchical Bayesian models in one framework: First, it flexibly leverages potentially many observed characteristics to personalize to new consumers. Second, it optimally adapts to the consumer's specific preferences as their choices are recorded over time. I develop an efficient Metropolis-within-Gibbs sampler for fully Bayesian inference and apply it in two discrete choice applications. Using data from a canonical conjoint study, I illustrate how HART discovers marketing opportunities for product design in new markets. In a CPG scanner data application, HART leverages observed characteristics to improve out-of-sample choice prediction by 60% for new consumers, and raises profits by 13% and 2% compared to conventional personalization approaches for new and known consumers, respectively.
<br>
<em>Presented at: ISMS Marketing Science Conference 2025
</em>
</div> 
\
**Optimal Categorical Instrumental Variables** \
 Revision requested at the _Journal of Business & Economic Statistics_.\
 [<a style="cursor:pointer;" onclick="toggleVisibility('abstract_CIV');">abstract</a>; [arXiv](https://arxiv.org/abs/2311.17021); [R package](https://thomaswiemann.com/civ/)].
<div id="abstract_CIV" style="display:none;">
This paper discusses estimation with a categorical instrumental variable in settings with potentially few observations per category. The proposed categorical instrumental variable estimator (CIV) leverages a regularization assumption that implies existence of a latent categorical variable with fixed finite support achieving the same first stage fit as the observed instrument. In asymptotic regimes that allow the number of observations per category to grow at arbitrary small polynomial rate with the sample size, I show that when the cardinality of the support of the optimal instrument is known, CIV is root-n asymptotically normal, achieves the same asymptotic variance as the oracle IV estimator that presumes knowledge of the optimal instrument, and is semiparametrically efficient under homoskedasticity. Under-specifying the number of support points reduces efficiency but maintains asymptotic normality. In an application that leverages judge fixed effects as instruments, CIV compares favorably to commonly used jackknife-based instrumental variable estimators. 
<br>
<em>Presented at: International Association for Applied Econometrics 2023, North American Winter Meeting of the Econometric Society 2024
</em>
</div> 
\
**An Introduction to Double/Debiased Machine Learning**\
with [Achim Ahrens](https://achimahrens.de/), [Victor Chernozhukov](https://www.victorchernozhukov.com/), [Christian Hansen](https://voices.uchicago.edu/christianhansen/), [Damian Kozbur](https://www.econ.uzh.ch/en/people/faculty/kozbur.html), [Mark Schaffer](https://ideas.repec.org/e/psc51.html).\
Revision requested at the _Journal of Economic Literature_.\
 [<a style="cursor:pointer;" onclick="toggleVisibility('abstract_jel');">abstract</a>; [arXiv](https://arxiv.org/abs/2504.08324); [tutorial](https://dmlguide.github.io/)].
<div id="abstract_jel" style="display:none;">
This paper provides a practical introduction to Double/Debiased Machine Learning (DML). DML provides a general approach to performing inference about a target parameter in the presence of nuisance parameters. The aim of DML is to reduce the impact of nuisance parameter estimation on estimators of the parameter of interest. We describe DML and its two essential components: Neyman orthogonality and cross-fitting. We highlight that DML reduces functional form dependence and accommodates the use of complex data types, such as text data. We illustrate its application through three empirical examples that demonstrate DML's applicability in cross-sectional and panel settings.
</div> 
\
**Demand Estimation with Finitely Many Consumers** \
with [Jonas Lieber](https://jonaslieber.com/index.html).\
[<a style="cursor:pointer;" onclick="toggleVisibility('abstract_EZMPEC');">abstract</a>; [draft](/assets/pdfs/ezmpec_lw.pdf); [slides](/assets/pdfs/ezmpec_lw_slides.pdf)]
<div id="abstract_EZMPEC" style="display:none;">
Although market shares are frequently estimated via averages of finitely many consumer choices, commonly applied methods for demand estimation are not robust to estimation error in these shares. While non-negligible estimation error in market shares always introduces bias in the demand parameter estimators, the issue becomes most salient when estimated market shares are zero. In the presence of zero shares, widely applied estimators of the random coefficient logit model cannot be computed without ad-hoc data manipulations. This paper proposes a new estimator of demand parameters for settings with endogenous prices and estimated market shares that is robust to zero-valued market shares. The estimator generalizes the constrained optimization program of Dubé et al. (2012) with probabilistic bounds on the estimation error in market shares. We show consistency as the number of markets $T$ grows sufficiently slowly relative to the number of consumers $n$ such that $\log(T)/n\to 0$, and provide confidence intervals under the same regime. Simulations suggest improved finite sample properties of the proposed estimator to conventional alternatives.
<br>
<em>Presented at: Optimization Conscious Econometrics Conference 2023, North American Summer Meetings of the Econometric Society 2023
</em>
</div> 
\
**Guarantees on Correct Conclusions with Incorrect Likelihoods** \
[<a style="cursor:pointer;" onclick="toggleVisibility('abstract_sign');">abstract</a>; [draft](/assets/pdfs/sign_w.pdf)]
<div id="abstract_sign" style="display:none;">
This note studies robustness properties of (non)linear control function estimands such as (mixed) Logistic or Poisson pseudo maximum likelihood estimands. I show that under misspecification, commonly-applied estimands are not informative about the sign of the true partial effects. For example, (mixed) logistic regression estimands potentially imply positive partial effects even if all true partial effects are negative. I provide sufficient conditions to admit valid conclusions about the sign of partial effects. For a large class of estimands, including common pseudo maximum likelihood estimands based on natural exponential family distributions, nonparametrically conditioning on the control function is sufficient for sign preservation.
</div> 
\
**Effects of Health Care Policy Uncertainty on Households' Portfolio Choice**\
with [Robin L Lumsdaine](https://www.american.edu/kogod/faculty/lumsdain.cfm).\
[<a style="cursor:pointer;" onclick="toggleVisibility('abstract_HCPU');">abstract</a>; [draft](/assets/pdfs/hcpu_wl.pdf); [slides](/assets/pdfs/hcpu_wl_slides.pdf)]
<div id="abstract_HCPU" style="display:none;">
This paper develops a nonparametric identification approach for causal effects of an endogenous macroeconomic variable on microeconomic outcomes. The key assumption is the existence of an exogenous variable that shifts responsiveness to the variable of interest without shifting responsiveness to other macroeconomic time series. We apply the approach  to study the effect of health care policy uncertainty (HCPU) on households' portfolio choice using health shocks to capture cross-sectional heterogeneity. Under the additional assumption of risk averse agents, our approach provides an informative bound on the average causal effect of HCPU. The empirical results highlight HCPU as an important determinant of households' financial behavior, and showcase substantial heterogeneity in HCPU effects across varying unexpected changes to health.
<br>
<em>
Presented at: Stanford Institute for Theoretical Economics 2019, International Association for Applied Econometrics 2019, Society for Financial Econometrics 2019, Royal Economic Society 2023
</em>
</div> 


## Publications

**Model Averaging and Double Machine Learning**\
with [Achim Ahrens](https://achimahrens.de/), [Christian Hansen](https://voices.uchicago.edu/christianhansen/), [Mark Schaffer](https://ideas.repec.org/e/psc51.html).\
_Journal of Applied Econometrics, 2025, 40(3): 249-269._\
[<a style="cursor:pointer;" onclick="toggleVisibility('abstract_ddml_applied');">abstract</a>; [article](https://onlinelibrary.wiley.com/doi/10.1002/jae.3103); [Stata package](https://statalasso.github.io/docs/ddml/); [R package](https://thomaswiemann.com/ddml/)]
<div id="abstract_ddml_applied" style="display:none;"> 
This paper discusses pairing double/debiased machine learning (DDML) with stacking, a model averaging method for combining multiple candidate learners, to estimate structural parameters. We introduce two new stacking approaches for DDML: short-stacking exploits the cross-fitting step of DDML to substantially reduce the computational burden and pooled stacking enforces common stacking weights over cross-fitting folds. Using calibrated simulation studies and two applications estimating gender gaps in citations and wages, we show that DDML with stacking is more robust to partially unknown functional forms than common alternative approaches based on single pre-selected learners. We provide Stata and R software implementing our proposals.
<br>
<em>
Presented at: Machine Learning in Economics Summer Institute 2022
</em>
</div> 
\
**ddml: Double/debiased machine learning in Stata**\
with [Achim Ahrens](https://achimahrens.de/), [Christian Hansen](https://voices.uchicago.edu/christianhansen/), [Mark Schaffer](https://ideas.repec.org/e/psc51.html).\
_Stata Journal, 2024, 24(1): 3-45._\
[<a style="cursor:pointer;" onclick="toggleVisibility('abstract_ddml_stata');">abstract</a>; [article](https://journals.sagepub.com/doi/full/10.1177/1536867X241233641); [Stata package](https://statalasso.github.io/docs/ddml/); [R package](https://thomaswiemann.com/ddml/)] 
<div id="abstract_ddml_stata" style="display:none;">
We introduce the package ddml for Double/Debiased Machine Learning (DDML) in Stata. Estimators of causal parameters for five different econometric models are supported, allowing for flexible estimation of causal effects of endogenous variables in settings with unknown functional forms and/or many exogenous variables. ddml is compatible with many existing supervised machine learning programs in Stata. We recommend using DDML in combination with stacking estimation which combines multiple machine learners into a final predictor. We provide Monte Carlo evidence to support our recommendation.
</div> 

## Work in Progress

**Machine Learning learns Bayes**\
with Andrew Bai, [Sanjog Misra](https://sanjogmisra.com/).

## Software

- [``ddml``: Double/Debiased Machine Learning in Stata](https://statalasso.github.io/docs/ddml/)
- [``ddml``: Double/Debiased Machine Learning in R](https://thomaswiemann.com/ddml/)\
[![CRAN
Version](https://www.r-pkg.org/badges/version/ddml)](https://cran.r-project.org/package=ddml)
[![CRAN
Downloads](https://cranlogs.r-pkg.org/badges/ddml)](https://cran.r-project.org/package=ddml)
- [``kcmeans``: Conditional Expectation Function Estimation with K-Conditional-Means](https://thomaswiemann.com/kcmeans/)\
[![CRAN
Version](https://www.r-pkg.org/badges/version/kcmeans)](https://cran.r-project.org/package=kcmeans)
[![CRAN
Downloads](https://cranlogs.r-pkg.org/badges/kcmeans)](https://cran.r-project.org/package=kcmeans)
- [``civ``: Categorical Instrumental Variables](https://thomaswiemann.com/civ/)\
[![CRAN
Version](https://www.r-pkg.org/badges/version/civ)](https://cran.r-project.org/package=civ)
[![CRAN
Downloads](https://cranlogs.r-pkg.org/badges/civ)](https://cran.r-project.org/package=civ)


## Teaching

**Econometrics &ndash; Econ 21020 (Spring 2022)**\
[[course website](econ21020); [syllabus](econ21020); [course material](econ21020/material); [evaluations](assets/teaching/Spring2022-Econ-21020/Econ_21020_wiemann_evaluations.pdf)]