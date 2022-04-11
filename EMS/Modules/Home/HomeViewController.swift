import UIKit

class HomeViewController: UIViewController, AlertPresentable {
    private var viewModel: HomeViewModelProtocol

    @IBOutlet private weak var dischargeContentView: UIView!
    @IBOutlet private weak var dischargeTitleLabel: UILabel! {
        didSet {
            dischargeTitleLabel.textColor = .white
            dischargeTitleLabel.font = UIFont.boldSystemFont(ofSize: LayoutConstants.smallTitleFontSize)
            let text = NSLocalizedString("home_screen__discharge_title_label", comment: "")
            let textRange = NSRange(location: 0, length: text.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(.underlineStyle,
                                        value: NSUnderlineStyle.single.rawValue,
                                        range: textRange)
            dischargeTitleLabel.attributedText = attributedText
        }
    }
    @IBOutlet private weak var dischargeLabel: UILabel! {
        didSet {
            dischargeLabel.textColor = .white
            dischargeLabel.font = UIFont.boldSystemFont(ofSize: LayoutConstants.smallBodyFontSize)
        }
    }

    @IBOutlet private weak var chargeContentView: UIView!
    @IBOutlet private weak var chargeTitleLabel: UILabel! {
        didSet {
            chargeTitleLabel.textColor = .white
            chargeTitleLabel.font = UIFont.boldSystemFont(ofSize: LayoutConstants.smallTitleFontSize)
            let text = NSLocalizedString("home_screen__charge_title_label", comment: "")
            let textRange = NSRange(location: 0, length: text.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(.underlineStyle,
                                        value: NSUnderlineStyle.single.rawValue,
                                        range: textRange)
            chargeTitleLabel.attributedText = attributedText
        }
    }
    @IBOutlet private weak var chargeLabel: UILabel! {
        didSet {
            chargeLabel.textColor = .white
            chargeLabel.font = UIFont.boldSystemFont(ofSize: LayoutConstants.smallBodyFontSize)
        }
    }

    @IBOutlet private weak var liveDataContentView: UIView!
    @IBOutlet private weak var liveDataStackView: UIStackView!
    @IBOutlet private weak var liveDataTitleLabel: UILabel! {
        didSet {
            liveDataTitleLabel.font = UIFont.boldSystemFont(ofSize: LayoutConstants.titleFontSize)
            let text = NSLocalizedString("home_screen__live_data", comment: "")
            let textRange = NSRange(location: 0, length: text.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(.underlineStyle,
                                        value: NSUnderlineStyle.single.rawValue,
                                        range: textRange)
            liveDataTitleLabel.attributedText = attributedText
        }
    }
    @IBOutlet private weak var liveDataBuildingDemandLabel: UILabel! {
        didSet {
            liveDataBuildingDemandLabel.font = UIFont.boldSystemFont(ofSize: LayoutConstants.smallBodyFontSize)
        }
    }
    @IBOutlet private weak var liveDataSolarLabel: UILabel! {
        didSet {
            liveDataSolarLabel.font = UIFont.boldSystemFont(ofSize: LayoutConstants.smallBodyFontSize)
        }
    }
    @IBOutlet private weak var liveDataGridLabel: UILabel! {
        didSet {
            liveDataGridLabel.font = UIFont.boldSystemFont(ofSize: LayoutConstants.smallBodyFontSize)
        }
    }

    @IBOutlet private weak var statisticsContentView: UIView!
    @IBOutlet private weak var statisticsStackView: UIStackView!
    @IBOutlet private weak var statisticsTitleLabel: UILabel! {
        didSet {
            statisticsTitleLabel.font = UIFont.boldSystemFont(ofSize: LayoutConstants.titleFontSize)
            let text = NSLocalizedString("home_screen__statistics_title", comment: "")
            let textRange = NSRange(location: 0, length: text.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(.underlineStyle,
                                        value: NSUnderlineStyle.single.rawValue,
                                        range: textRange)
            statisticsTitleLabel.attributedText = attributedText
        }
    }
    @IBOutlet private weak var statisticsPvPercentageLabel: UILabel! {
        didSet {
            statisticsPvPercentageLabel.font = UIFont.boldSystemFont(ofSize: LayoutConstants.smallBodyFontSize)
        }
    }
    @IBOutlet private weak var statisticsGridPercentageLabel: UILabel! {
        didSet {
            statisticsGridPercentageLabel.font = UIFont.boldSystemFont(ofSize: LayoutConstants.smallBodyFontSize)
        }
    }
    @IBOutlet private weak var statisticsButton: UIButton!

    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        configureViewModel()
    }

    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupAccessibilityIds()

        viewModel.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dischargeContentView.layer.cornerRadius = LayoutConstants.cornerRadius
        dischargeContentView.layer.masksToBounds = true

        chargeContentView.layer.cornerRadius = LayoutConstants.cornerRadius
        chargeContentView.layer.masksToBounds = true

        liveDataContentView.layer.cornerRadius = LayoutConstants.cornerRadius
        liveDataContentView.layer.masksToBounds = true
        liveDataContentView.layer.borderWidth = LayoutConstants.borderWidth
        liveDataContentView.layer.borderColor = UIColor.label.cgColor

        statisticsContentView.layer.cornerRadius = LayoutConstants.cornerRadius
        statisticsContentView.layer.masksToBounds = true
        statisticsContentView.layer.borderWidth = LayoutConstants.borderWidth
        statisticsContentView.layer.borderColor = UIColor.label.cgColor
    }

    func updateWidgets() {
        dischargeLabel.text = viewModel.totalDischarged
        chargeLabel.text = viewModel.totalCharged
        statisticsPvPercentageLabel.text = viewModel.pvPercentage
        statisticsGridPercentageLabel.text = viewModel.gridPercentage
    }

    func updateLiveDataWidget() {
        liveDataBuildingDemandLabel.text = viewModel.liveDataBuildingDemandText
        liveDataSolarLabel.text = viewModel.liveDataSolarText
        liveDataGridLabel.text = viewModel.liveDataGridText
    }
}

private extension HomeViewController {
    func configureViewModel() {
        viewModel.didGetHistoricData = { [weak self] success in
            guard let self = self else { return }
            if success {
                self.updateWidgets()
            } else {
                self.presentErrorAlert(message: NSLocalizedString("something_went_wrong", comment: ""),
                                       acceptCompletion: nil,
                                       viewController: self)
            }
        }
        viewModel.didGetLiveData = { [weak self] success in
            guard let self = self else { return }
            if success {
                self.updateLiveDataWidget()
            } else {
                self.presentErrorAlert(message: NSLocalizedString("something_went_wrong", comment: ""),
                                       acceptCompletion: nil,
                                       viewController: self)
            }
        }
    }

    func setupViews() {
        view.backgroundColor = .white
        title = NSLocalizedString("home_screen__title", comment: "")
        liveDataStackView.setCustomSpacing(LayoutConstants.baseSpacing2, after: liveDataTitleLabel)
        statisticsStackView.setCustomSpacing(LayoutConstants.baseSpacing2, after: statisticsTitleLabel)

        statisticsButton.addAction(UIAction(handler: {  [weak self] _ in
            self?.viewModel.openDetail()
        }), for: .touchUpInside)
    }

    func setupAccessibilityIds() {
        dischargeTitleLabel.accessibilityIdentifier = AccessibilityIdentifiers.HomeViewController.DischargeLabel
        statisticsButton.accessibilityIdentifier = AccessibilityIdentifiers.HomeViewController.DetailWidgetButton
    }
}
